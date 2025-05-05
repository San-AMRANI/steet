import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' show CupertinoIcons;

class RoomDetailsPage extends StatelessWidget {
  const RoomDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isChatEnabled = false;
    bool isMicOn = true;
    bool isCameraOn = true;

    return Scaffold(
      body: Stack(
        children: [
          // Body Content
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width / 1.7,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiary,
                        image: const DecorationImage(
                          image: AssetImage(
                              'lib/assets/images/room_image.jpg'), // Replace with your image
                          fit: BoxFit.cover,
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
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Theme.of(context)
                                  .colorScheme
                                  .tertiary
                                  .withValues(alpha: 150),
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
                    children: const [
                      Text(
                        "Room Title",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Room description goes here. Add more details about the room.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Room Members", // room participants when the room is public
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Wrap(
                          spacing: 8.0,
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage(
                                  'lib/assets/images/member1.jpg'), // Replace with your image
                            ),
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage(
                                  'lib/assets/images/member2.jpg'), // Replace with your image
                            ),
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage(
                                  'lib/assets/images/member3.jpg'), // Replace with your image
                            ),
                          ],
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
                          backgroundImage: AssetImage(
                              'lib/assets/images/creator.jpg'), // Replace with creator's image
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Creator Name", // Replace with creator's name
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Created on: Jan 1, 2023", // Replace with creation date
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
            right: 0,
            child: AppBar(
              // title: const Text(
              //   "Room Details",
              //   style: TextStyle(color: Colors.white, fontSize: 14),
              // ),
              // centerTitle: false,
              leading: IconButton(
                icon: const Icon(CupertinoIcons.back, color: Colors.white, semanticLabel: "Back"),
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
