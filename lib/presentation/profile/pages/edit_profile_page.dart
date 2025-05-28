import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steet/domain/entities/student.dart';
import 'package:steet/presentation/providers/student_provider.dart';

import 'package:steet/presentation/widgets/subpage_appbar.dart';
import 'package:steet/presentation/profile/widgets/info_section.dart';
import 'package:steet/presentation/profile/widgets/info_row.dart';
import 'package:steet/presentation/profile/widgets/personal_info_bottom_sheet.dart';
import 'package:steet/presentation/profile/widgets/account_details_bottom_sheet.dart';
import 'package:steet/presentation/profile/widgets/additional_info_bottom_sheet.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  final Student? authStudent;
  const EditProfilePage({
    super.key,
    required this.authStudent,
  });

  @override
  ConsumerState<EditProfilePage> createState() =>
      _EditProfilePageState(authStudent);
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  final Student? authStudent;
  _EditProfilePageState(this.authStudent);
  // Controllers for the text fields
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final dobController = TextEditingController();
  final majorController = TextEditingController();

  // Form key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _controllersInitialized = false;
  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    dobController.dispose();
    majorController.dispose();
    super.dispose();
  }

  void _onSaveProfile() async {
    final updatedStudent = authStudent!.copyWith(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      userName: userNameController.text,
      email: emailController.text,
      dob: DateTime.tryParse(dobController.text)!,
      major: majorController.text,
    );

    try {
      await ref.read(studentNotifierProvider.notifier).updateStudent(updatedStudent);
      setState(() {}); // Refresh UI if needed
      Navigator.pop(context); // Close the bottom sheet
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      Navigator.pop(context); // Close the bottom sheet
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update profile, please try again later!'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showEditPersonalInfoBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return PersonalInfoBottomSheet(
          firstNameController: firstNameController,
          lastNameController: lastNameController,
          formKey: formKey,
          onSave: () => setState(_onSaveProfile),
        );
      },
    );
  }

  void _showEditAccountDetailsBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return AccountDetailsBottomSheet(
          userNameController: userNameController,
          emailController: emailController,
          formKey: formKey,
          onSave: () => setState(_onSaveProfile),
        );
      },
    );
  }

  void _showEditAdditionalInfoBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return AdditionalInfoBottomSheet(
          dobController: dobController,
          majorController: majorController,
          formKey: formKey,
          onSave: () => setState(_onSaveProfile),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing student data if available
    if (authStudent != null) {
      firstNameController.text = authStudent!.firstName;
      lastNameController.text = authStudent!.lastName;
      userNameController.text = authStudent!.userName;
      emailController.text = authStudent!.email;
      dobController.text =
          authStudent!.dob.toIso8601String().split('T').first; // Format date
      majorController.text = authStudent!.major;
    }
    _controllersInitialized = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(
        title: 'Profile',
        avatarUrl: authStudent?.profilePictureUrl ?? '',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Personal Information Section
                    InfoSection(
                      title: 'Full Name',
                      onEditPressed: _showEditPersonalInfoBottomSheet,
                      children: [
                        InfoRow(
                          label: 'First Name',
                          value: firstNameController.text,
                          icon: CupertinoIcons.person,
                        ),
                        const SizedBox(height: 12),
                        InfoRow(
                          label: 'Last Name',
                          value: lastNameController.text,
                          icon: CupertinoIcons.person_fill,
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Account Details Section
                    InfoSection(
                      title: 'Account Details',
                      onEditPressed: _showEditAccountDetailsBottomSheet,
                      children: [
                        InfoRow(
                          label: 'Username',
                          value: userNameController.text,
                          icon: CupertinoIcons.profile_circled,
                        ),
                        const SizedBox(height: 12),
                        InfoRow(
                          label: 'Email',
                          value: emailController.text,
                          icon: CupertinoIcons.mail,
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Additional Information Section
                    InfoSection(
                      title: 'Additional Information',
                      onEditPressed: _showEditAdditionalInfoBottomSheet,
                      children: [
                        InfoRow(
                          label: 'Date of Birth',
                          value: dobController.text,
                          icon: CupertinoIcons.calendar,
                        ),
                        const SizedBox(height: 12),
                        InfoRow(
                          label: 'Major',
                          value: majorController.text,
                          icon: CupertinoIcons.book,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
