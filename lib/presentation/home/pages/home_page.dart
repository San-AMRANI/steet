import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steet/domain/entities/pub_room.dart';
import 'package:steet/presentation/widgets/rooms_list_1.dart';
import 'package:steet/presentation/providers/pub_room_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pubRoomsAsync = ref.watch(pubRoomsProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: RefreshIndicator(
        onRefresh: () async {
          // Refresh the data
          ref.invalidate(pubRoomsProvider);
          return Future.value();
        },
        child: pubRoomsAsync.when(
          data: (data) {
            return _HomePageBody(rooms: data);
          },
          error: (error, stackTrace) {
            return Center(child: Text('Error: $error'));
          },
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  final List<PubRoom> rooms;
  const _HomePageBody({required this.rooms});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            RoomsList1(
              categoryTitle: "🔥 Populare Rooms",
              rooms: rooms,
            ),
            const SizedBox(height: 10),
            RoomsList1(
              categoryTitle: "Public Rooms",
              rooms: rooms,
            )
            // const SizedBox(height: 10),
            // RoomsList1(
            //     categoryTitle: "Private Rooms",
            //     itemCount: 3,
            //     itemLabelBuilder: (index) {
            //       return "Room Name $index";
            //     }),
          ],
        ),
      ),
    );
  }
}
