import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steet/domain/entities/pub_room.dart';
import 'package:steet/presentation/providers/pub_room_provider.dart';
import 'package:steet/presentation/rooms/pages/room_details_page.dart';

class PubRoomListPage extends ConsumerWidget {
  const PubRoomListPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pubRoomsAsync = ref.watch(pubRoomsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Public Rooms'),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          // Invalidate the provider to force a refresh
          ref.invalidate(pubRoomsProvider);
          return Future.value();
        },
        child: pubRoomsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => _ErrorView(error: error),
          data: (rooms) => _RoomListView(rooms: rooms),
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final Object error;

  const _ErrorView({required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48),
            const SizedBox(height: 16),
            const Text(
              'Error loading rooms',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Consumer(
              builder: (context, ref, _) => TextButton.icon(                onPressed: () => ref.invalidate(pubRoomsProvider),
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoomListView extends ConsumerWidget {
  final List<PubRoom> rooms;

  const _RoomListView({required this.rooms});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (rooms.isEmpty) {
      return const Center(child: Text('No public rooms available'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: rooms.length,
      itemBuilder: (context, index) => _RoomCard(room: rooms[index]),
    );
  }
}

class _RoomCard extends StatelessWidget {
  final PubRoom room;

  const _RoomCard({required this.room});

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} years ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} months ago';
    } else if (difference.inDays > 7) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RoomDetailsPage()),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Text(
                      room.name[0].toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          room.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.people_outline, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              '${room.participation.length} members',
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Icon(Icons.access_time, 
                              size: 16,
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _formatTimestamp(room.createdAt),
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (room.description.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  room.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
