import 'package:flutter/material.dart';
import 'package:steet/presentation/rooms/pages/room_details_page.dart';
import 'package:steet/domain/entities/pub_room.dart';

class RoomsList1 extends StatelessWidget {
  final String categoryTitle;
  final List<PubRoom> rooms;

  const RoomsList1({
    super.key,
    required this.categoryTitle,
    required this.rooms,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            categoryTitle,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: PageController(viewportFraction: 0.85),
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              final room = rooms[index];
              return Padding(
                padding: const EdgeInsets.only(right: 8.0, bottom: 0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RoomDetailsPage(room: room),
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.only(bottom: 0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      border: Border.all(
                        color: Colors.black12,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      contentPadding:
                          const EdgeInsets.only(right: 2, left: 10, bottom: 0),
                      title: Text(
                        room.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        room.description,
                        style: const TextStyle(
                          color: Colors.white70,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: IconButton(
                        iconSize: 24,
                        icon: const CircleAvatar(
                          radius: 18,
                          backgroundImage:
                              AssetImage('lib/assets/images/logo.png'),
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {
                          // Handle button press
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
