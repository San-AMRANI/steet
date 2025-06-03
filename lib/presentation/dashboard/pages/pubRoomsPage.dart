import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steet/presentation/providers/DashboardProvider.dart';

class PublicRoomsPage extends ConsumerWidget {
  const PublicRoomsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pubRooms = ref.watch(dashboardProvider).pubRooms;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Public Rooms'),
      ),
      body: pubRooms.isEmpty
          ? const Center(child: Text('No public rooms found.'))
          : ListView.builder(
              itemCount: pubRooms.length,
              itemBuilder: (context, index) {
                final room = pubRooms[index];
                return ListTile(
                  title: Text(room.name),
                  subtitle: Text(room.description),
                  leading: const Icon(Icons.public),
                );
              },
            ),
    );
  }
}