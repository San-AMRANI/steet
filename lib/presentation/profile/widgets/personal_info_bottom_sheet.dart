import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:steet/presentation/widgets/my_text_field.dart';

/// A widget that displays the bottom sheet for editing personal information
class PersonalInfoBottomSheet extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final GlobalKey<FormState> formKey;
  final VoidCallback onSave;

  const PersonalInfoBottomSheet({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
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
                'Edit Personal Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
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
