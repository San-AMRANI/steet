import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:steet/presentation/widgets/my_text_field.dart';

/// A widget that displays the bottom sheet for editing account details
class AccountDetailsBottomSheet extends StatelessWidget {
  final TextEditingController userNameController;
  final TextEditingController emailController;
  final GlobalKey<FormState> formKey;
  final VoidCallback onSave;

  const AccountDetailsBottomSheet({
    super.key,
    required this.userNameController,
    required this.emailController,
    required this.formKey,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 20,
        left: 20,
        right: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Edit Account Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      onSave();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
