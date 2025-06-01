import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steet/domain/entities/room.dart';
import 'package:steet/domain/entities/prv_room.dart';
import 'package:steet/domain/entities/pub_room.dart';
import 'package:steet/presentation/rooms/widgets/room_card.dart';
import 'package:steet/presentation/rooms/pages/create_room_page.dart';
import 'package:steet/data/data_sources/mock_rooms_data_source.dart';

// TODO: Replace with actual user ID from auth provider when available
const currentUserId = 'current_user_id';

class RoomsPage extends ConsumerStatefulWidget {
  const RoomsPage({super.key});

  @override
  ConsumerState<RoomsPage> createState() => _RoomsPageState();
}

class _RoomsPageState extends ConsumerState<RoomsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _mockDataSource = MockRoomsDataSource();

  // State variables to hold the rooms
  List<Room> _ownedRooms = [];
  List<Room> _memberRooms = [];
  List<Room> _publicRooms = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadRooms();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadRooms() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      // Load all types of rooms
      final createdRooms =
          await _mockDataSource.getUserCreatedPrvRooms(currentUserId);
      final memberRooms = await _mockDataSource.getUserPrvRooms(currentUserId);
      final publicRooms = await _mockDataSource.getPubRooms();

      // Filter member rooms to exclude owned rooms
      final nonOwnedMemberRooms =
          memberRooms.where((room) => room.createdBy != currentUserId).toList();

      setState(() {
        _ownedRooms = createdRooms;
        _memberRooms = nonOwnedMemberRooms;
        _publicRooms = publicRooms;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _navigateToCreateRoom() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateRoomPage(isAdmin: false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Owned'),
            Tab(text: 'Member'),
            Tab(text: 'Public'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error: $_error'))
              : RefreshIndicator(
                  onRefresh: _loadRooms,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _OwnedRoomsList(
                        rooms: _ownedRooms,
                        onCreateRoom: _navigateToCreateRoom,
                      ),
                      _RoomsList(rooms: _memberRooms, type: RoomType.member),
                      _RoomsList(rooms: _publicRooms, type: RoomType.public),
                    ],
                  ),
                ),
    );
  }
}

enum RoomType { owned, member, public }

class _OwnedRoomsList extends StatelessWidget {
  final List<Room> rooms;
  final VoidCallback onCreateRoom;

  const _OwnedRoomsList({
    required this.rooms,
    required this.onCreateRoom,
  });

  @override
  Widget build(BuildContext context) {
    if (rooms.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              'Create your first room',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onCreateRoom,
              icon: const Icon(Icons.add),
              label: const Text('Create Room'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              final room = rooms[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: RoomCard(room: room),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: 200,
            child: ElevatedButton.icon(
              onPressed: onCreateRoom,
              icon: const Icon(Icons.add),
              label: const Text('Create New Room'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _RoomsList extends StatelessWidget {
  final List<Room> rooms;
  final RoomType type;

  const _RoomsList({
    required this.rooms,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    if (rooms.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getEmptyIcon(),
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              _getEmptyMessage(),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: rooms.length,
      itemBuilder: (context, index) {
        final room = rooms[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: RoomCard(room: room),
        );
      },
    );
  }

  IconData _getEmptyIcon() {
    switch (type) {
      case RoomType.owned:
        return Icons.add_circle_outline;
      case RoomType.member:
        return Icons.groups_outlined;
      case RoomType.public:
        return Icons.public;
    }
  }

  String _getEmptyMessage() {
    switch (type) {
      case RoomType.owned:
        return 'Create your first room';
      case RoomType.member:
        return 'Join a room to get started';
      case RoomType.public:
        return 'No public rooms joined yet';
    }
  }
}
