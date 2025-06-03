import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steet/domain/entities/prv_room.dart';
import 'package:steet/presentation/providers/DashboardProvider.dart';

class PrivateRoomsPage extends ConsumerWidget {
  const PrivateRoomsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prvRooms = ref.watch(dashboardProvider).prvRooms;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Private Rooms'),
      ),
      body: prvRooms.isEmpty
          ? const Center(child: Text('No private rooms found.'))
          : ListView.builder(
              itemCount: prvRooms.length,
              itemBuilder: (context, index) {
                final room = prvRooms[index];
                return ListTile(
                  onTap: () {
                    prvRoomModelSheet(context, room);
                  },
                  title: Text(room.name),
                  subtitle: Text(room.description),
                  leading: const Icon(Icons.lock),
                );
              },
            ),
    );
  }

  void prvRoomModelSheet(BuildContext context, PrvRoom room) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => 
      Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Private Room Details',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Text('Room Name: ${room.name}'),
              Text('Room Description: ${room.description}'),
              Text('Room ID: ${room.id}'),
              Text('Room Image: ${room.imageUrl ?? 'No image available'}'),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,                
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 50, 63, 252),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Close',
                    style: TextStyle(color:Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
