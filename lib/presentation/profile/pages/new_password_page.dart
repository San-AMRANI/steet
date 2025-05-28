import 'package:flutter/material.dart';
import 'package:steet/domain/entities/student.dart';
import 'package:steet/presentation/widgets/new_password.dart';
import 'package:steet/presentation/widgets/subpage_appbar.dart';

class NewPasswordPage extends StatelessWidget {
  // Controllers for the text fields
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Student? authStudent;
  NewPasswordPage({super.key, this.authStudent});

  @override
  Widget build(BuildContext context) {
  final theme = Theme.of(context);

    return Scaffold(
      appBar: SubPageAppBar(title: "New Password", avatarUrl: authStudent?.profilePictureUrl ?? ""),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //! we may add an email confirmation field here
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
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  onPressed: () {
                    // Handle save logic here
                  },
                  child: const Text('Save Password', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}