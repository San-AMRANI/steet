import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steet/presentation/profile/pages/edit_profile_picture_page.dart';
import 'package:steet/presentation/profile/pages/new_password_page.dart';
import 'package:steet/presentation/widgets/my_text_icon_button.dart';
import 'edit_profile_page.dart';
import 'package:steet/presentation/providers/student_provider.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});
  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final String _studentId = '62257c22-5825-4fb8-9839-3bd001ce2c06';
  Object? _lastError;

  @override
  void initState() {
    super.initState();
    // Fetch student data when the widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(studentNotifierProvider.notifier).getStudentById(_studentId);
    });
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final studentState = ref.watch(studentNotifierProvider);
    final student = studentState.student;
    final isLoading = studentState.isLoading;
    final error = studentState.error;
    
  print('url profffile ${student?.profilePictureUrl}');

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    
    if (error != null && student == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: $error'),
            ElevatedButton(
              onPressed: () {
                ref.read(studentNotifierProvider.notifier).getStudentById(_studentId);
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }
    return SafeArea(
      child: Padding(
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
                      child: student == null
                          ? const Icon(Icons.person, size: 60)
                          : CachedNetworkImage(
                              imageUrl: student.profilePictureUrl ?? '',
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
                    '${student?.lastName ?? ''} ${student?.firstName ?? ''}',
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
              onPressed: student == null
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Failed to load your data. Please check your internet connection.'),
                        ),
                      );
                    }
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfilePage(
                            authStudent: student,
                          ),
                        ),
                      );
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
              onPressed: student == null
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Failed to load your data. Please check your internet connection.'),
                        ),
                      );
                    }
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfilePicturePage(
                            authStudent: student,
                          ),
                        ),
                      );
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewPasswordPage(authStudent: student),
                  ),
                );
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
              isFullWidth: true,
            ),
          ],
        ),
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
      },
    );
  }
}
