import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:steet/presentation/widgets/my_text_field.dart';
import 'package:steet/presentation/widgets/subpage_appbar.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Controllers for the text fields
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final userNameController = TextEditingController();
    final emailController = TextEditingController();
    final dobController = TextEditingController();
    final majorController = TextEditingController();

    return Scaffold(
      appBar: SubPageAppBar(
        title: 'Edit Profile',
        avatarUrl: 'https://www.amranihassan.site/avatar.png',
      ),
      
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Personal Information',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              MyTextField(
                labelText: 'First Name',
                hintText: 'Enter your first name',
                controller: firstNameController,
                obscureText: false,
                keyboardType: TextInputType.text,
                prefixIcon: Icons.person,
              ),
              const SizedBox(height: 16),
              MyTextField(
                labelText: 'Last Name',
                hintText: 'Enter your last name',
                controller: lastNameController,
                obscureText: false,
                keyboardType: TextInputType.text,
                prefixIcon: Icons.person_outline,
              ),
              const SizedBox(height: 24),
              const Text(
                'Account Details',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              MyTextField(
                labelText: 'Username',
                hintText: 'Enter your username',
                controller: userNameController,
                obscureText: false,
                keyboardType: TextInputType.text,
                prefixIcon: Icons.account_circle,
              ),
              const SizedBox(height: 16),
              MyTextField(
                labelText: 'Email',
                hintText: 'Enter your email',
                controller: emailController,
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.email,
              ),
              const SizedBox(height: 24),
              const Text(
                'Additional Information',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              MyTextField(
                labelText: 'Date of Birth',
                hintText: 'Enter your date of birth',
                controller: dobController,
                obscureText: false,
                keyboardType: TextInputType.datetime,
                prefixIcon: Icons.calendar_today,
              ),
              const SizedBox(height: 16),
              MyTextField(
                labelText: 'Major',
                hintText: 'Enter your major',
                controller: majorController,
                obscureText: false,
                keyboardType: TextInputType.text,
                prefixIcon: Icons.school,
              ),
              const Spacer(),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  onPressed: () {
                    // Handle save logic here
                  },
                  child: const Text('Save Changes', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}