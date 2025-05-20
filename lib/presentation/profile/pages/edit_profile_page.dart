import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:steet/presentation/widgets/my_text_field.dart';
import 'package:steet/presentation/widgets/subpage_appbar.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({
    super.key,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // Controllers for the text fields
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final dobController = TextEditingController();
  final majorController = TextEditingController();

  // Form key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: SubPageAppBar(
        title: 'Edit Profile',
        avatarUrl: 'https://www.amranihassan.site/avatar.png',
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
                      prefixIcon: CupertinoIcons.person,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'First name is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    MyTextField(
                      labelText: 'Last Name',
                      hintText: 'Enter your last name',
                      controller: lastNameController,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      prefixIcon: CupertinoIcons.person_fill,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Last name is required';
                        }
                        return null;
                      },
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
                      prefixIcon: CupertinoIcons.profile_circled,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    MyTextField(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      controller: emailController,
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: CupertinoIcons.mail,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        if (!RegExp(
                                r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}")
                            .hasMatch(value)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Additional Information',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1980),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          dobController.text =
                              "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                        }
                      },
                      child: AbsorbPointer(
                        child: MyTextField(
                          labelText: 'Date of Birth',
                          hintText: 'Enter your date of birth',
                          controller: dobController,
                          obscureText: false,
                          keyboardType: TextInputType.datetime,
                          prefixIcon: CupertinoIcons.calendar,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Date of birth is required';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    MyTextField(
                      labelText: 'Major',
                      hintText: 'Enter your major',
                      controller: majorController,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      prefixIcon: CupertinoIcons.book,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Major is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: theme.colorScheme.onPrimary,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                        ),
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            // Handle save logic here
                          }
                        },
                        child: const Text('Save Changes',
                            style: TextStyle(fontSize: 16)),
                      ),
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
