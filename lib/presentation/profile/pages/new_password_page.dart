import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steet/domain/entities/student.dart';
import 'package:steet/presentation/providers/auth_provider.dart';
import 'package:steet/presentation/widgets/my_text_field.dart';
import 'package:steet/presentation/widgets/new_password.dart';
import 'package:steet/presentation/widgets/subpage_appbar.dart';

class NewPasswordPage extends ConsumerStatefulWidget {
  final Student? authStudent;
  const NewPasswordPage({super.key, this.authStudent});

  @override
  ConsumerState<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends ConsumerState<NewPasswordPage> {
  // Controllers for the text fields
  final TextEditingController currentPasswordController =
      TextEditingController();

  final TextEditingController newPasswordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: SubPageAppBar(
          title: "New Password",
          avatarUrl: widget.authStudent?.profilePictureUrl ?? ""),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MyTextField(
                labelText: "Current Password",
                hintText: "your actual password",
                controller: currentPasswordController,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                prefixIcon: CupertinoIcons.lock_fill,
              ),
              const SizedBox(height: 30),
              NewPasswordWidget(
                passwordController: newPasswordController,
                confirmPasswordController: confirmPasswordController,
                formKey: formKey,
                title: "Create a new password",
              ),
              const Spacer(),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      ref.read(authProvider.notifier).changePassword(
                          widget.authStudent?.userName ?? "",
                          currentPasswordController.text,
                          newPasswordController.text,
                          confirmPasswordController.text).then(
                        (result) {
                          if (result) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Password changed successfully.'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Failed to change password.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill in the fields correctly.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: const Text('Save Password',
                      style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
