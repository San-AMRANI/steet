import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:steet/presentation/profile/pages/edit_profile_picture_page.dart';
import 'package:steet/presentation/profile/pages/new_password_page.dart';
// import 'package:steet/presentation/rooms/pages/profile_page.dart';
import 'package:steet/presentation/widgets/my_text_icon_button.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: theme.colorScheme.surface,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: 'https://www.amranihassan.site/avatar.png',
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                      width: 120,
                      height: 120,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'Amrani Hassan',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          MyTextIconButton(
            text: 'Personal Information',
            prefixIcon: CupertinoIcons.person,
            suffixIcon: Icons.arrow_forward_ios,
            onPressed: () {
              // print("Personal Information pressed");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfilePage(),
                  ));
            },
            textStyle: TextStyle(color: Colors.black),
            color: Theme.of(context).colorScheme.surface,
            border: null,
            isFullWidth: true,
          ),
          const SizedBox(height: 5),
          MyTextIconButton(
            text: 'Profile Picture',
            prefixIcon: CupertinoIcons.photo,
            suffixIcon: Icons.arrow_forward_ios,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfilePicturePage(),
                  ));
            },
            textStyle: TextStyle(color: Colors.black),
            color: Theme.of(context).colorScheme.surface,
            border: null,
            isFullWidth: true,
          ),
          const SizedBox(height: 25),
          MyTextIconButton(
            text: 'Change Password',
            prefixIcon: CupertinoIcons.lock_shield,
            suffixIcon: Icons.arrow_forward_ios,
            onPressed: () {
              // print("Change Password pressed");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewPasswordPage(),
                  ));
            },
            textStyle: TextStyle(color: Colors.black),
            color: Theme.of(context).colorScheme.surface,
            border: null,
            isFullWidth: true,
          ),
          const SizedBox(height: 5),
          MyTextIconButton(
            text: "Log Out",
            prefixIcon: Icons.logout,
            color: Theme.of(context).colorScheme.surface,
            textStyle: TextStyle(color: Colors.red),
            onPressed: () {
              _showLogoutConfirmationDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Are you sure you want to log out?',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyTextIconButton(
                      text: 'Cancel',
                      prefixIcon: Icons.cancel,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      textStyle: TextStyle(color: Colors.black),
                      color: Theme.of(context).colorScheme.surface,
                      border: null,
                      isFullWidth: false,
                    ),
                    MyTextIconButton(
                      text: 'Log Out',
                      prefixIcon: Icons.logout,
                      onPressed: () {
                        // Handle log out action
                        //! to be implemented
                      },
                      textStyle: TextStyle(color: Colors.white),
                      color: Colors.red,
                      border: null,
                      borderRadius: 14,
                      isFullWidth: false,
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
