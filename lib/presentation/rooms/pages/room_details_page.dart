import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:steet/domain/entities/prv_room.dart';
import 'package:steet/domain/entities/pub_room.dart';
import 'package:steet/domain/entities/room.dart';

class RoomDetailsPage extends StatelessWidget {
  final Room room;
  const RoomDetailsPage({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    bool isChatEnabled = true;
    bool isMicOn = false;
    bool isCameraOn = false;
    // print('Room Details: ${room.toString()}');
    return Scaffold(
      body: Stack(
        children: [
          // Body Content
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 1.7,
                      width: MediaQuery.of(context).size.width,
                      child: CachedNetworkImage(
                      imageUrl: room.imageUrl.isNotEmpty ? room.imageUrl : '',
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Container(
                        color: Theme.of(context).colorScheme.secondary,
                        child: const Icon(Icons.broken_image,
                          color: Colors.white, size: 48),
                      ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 50, // Adjust the height of the blur
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,                            colors: [
                              Colors.transparent,
                              Theme.of(context)
                                  .colorScheme
                                  .tertiary
                                  .withOpacity(0.6),
                            ],
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Wrap(
                              children: [
                                const SizedBox(width: 10),

                                // Chat icon
                                Icon(
                                  CupertinoIcons.chat_bubble_2_fill,
                                  color: isChatEnabled
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                                const SizedBox(width: 8),

                                // Mic icon
                                Icon(
                                  isMicOn ? Icons.mic : Icons.mic_off,
                                  color:
                                      isMicOn ? Colors.white : Colors.redAccent,
                                ),
                                const SizedBox(width: 8),

                                // Camera icon
                                Icon(
                                  isCameraOn
                                      ? CupertinoIcons.video_camera
                                      : Icons.videocam_off,
                                  color: isCameraOn
                                      ? Colors.white
                                      : Colors.redAccent,
                                ),
                              ],
                            ),
                            TextButton.icon(
                              onPressed: () {
                                // Add your button action here
                              },
                              icon: const Icon(
                                Icons.login,
                                color: Colors.white,
                              ),
                              label: const Text(
                                "Join", //ask to join (for private rooms)
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Add your room details widgets here
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        room.name, // room name
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        room.description,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Room Members", // room participants when the room is public
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Show member count with icon for PubRoom
                          if (room is PubRoom)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.people, size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${(room as PubRoom).participation.length}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Remove the Container with background and shadow, just show the member avatars/info directly
                      if (room is PubRoom && (room as PubRoom).participation.isNotEmpty)
                        Wrap(
                          spacing: 12.0,
                          runSpacing: 12.0,
                          children: List.generate(
                            (room as PubRoom).participation.length > 10
                                ? 10 // Limit to 10 avatars
                                : (room as PubRoom).participation.length,
                            (index) => Column(
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                                  child: Text(
                                    (room as PubRoom).participation[index].idStudent.substring(0, 1).toUpperCase(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              'No members have joined yet',
                              style: TextStyle(
                                color: Colors.grey,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),

                      // Show "more" indicator if there are more than 10 participants
                      if (room is PubRoom && (room as PubRoom).participation.length > 10)
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '+ ${(room as PubRoom).participation.length - 10} more',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Created By",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                AssetImage(''), // Replace with creator's image
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (room is PrvRoom ? (room as PrvRoom).createdBy : 'Steet'), // Print if exists, else 'Steet'
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Created on: ${room.createdAt.toLocal().toString().split(' ')[0]}", // Only the date part
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // AppBar with Back Button
          Positioned(
            top: 0,
            left: 0,
            right: 0,            child: AppBar(
              leading: IconButton(
                icon: const Icon(
                  CupertinoIcons.back,
                  color: Colors.black, // Changed to black as requested
                  semanticLabel: "Back"
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Colors.transparent,
              elevation: 0, // Remove shadow
            ),
          ),
        ],
      ),
    );
  }
}
