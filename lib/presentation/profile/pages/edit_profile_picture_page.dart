import 'package:flutter/material.dart';

class EditProfilePicturePage extends StatelessWidget {
  const EditProfilePicturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          "Edit Profile Picture",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}