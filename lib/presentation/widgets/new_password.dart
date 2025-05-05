import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'my_text_field.dart';

// the password creation may be used many times (while creating the account, changing the password, resetting it etc.)

/* 
  //? creating the account 
  NewPasswordWidget(
    passwordController: passwordController,
    confirmPasswordController: confirmPasswordController,
    formKey: formKey,
    title: "Create a new password",
  )

  //? changing the password
  NewPasswordWidget(
    passwordController: newPasswordController,
    confirmPasswordController: confirmPasswordController,
    oldPasswordController: oldPasswordController,
    formKey: formKey,
    title: "Change your password",
    showOldPassword: true,
  )

  //? resetting the password
  NewPasswordWidget(
    passwordController: resetPasswordController,
    confirmPasswordController: confirmResetPasswordController,
    formKey: formKey,
    title: "Reset your password",
  )

*/

class NewPasswordWidget extends StatefulWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  final GlobalKey<FormState> formKey;

  final String title;
  final bool showOldPassword;

  final String? passwordLabel;
  final String? confirmPasswordLabel;

  const NewPasswordWidget({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.formKey,
    this.title = "Create a new password",
    this.showOldPassword = false,
    this.passwordLabel,
    this.confirmPasswordLabel,
  });

  @override
  State<NewPasswordWidget> createState() => _NewPasswordWidgetState();
}

class _NewPasswordWidgetState extends State<NewPasswordWidget> {
  bool hasMinLength = false;
  bool hasNumber = false;
  bool hasUppercase = false;
  bool hasLowercase = false;

  void _validatePassword(String password) {
    setState(() {
      hasMinLength = password.length >= 8;
      hasNumber = password.contains(RegExp(r'[0-9]'));
      hasUppercase = password.contains(RegExp(r'[A-Z]'));
      hasLowercase = password.contains(RegExp(r'[a-z]'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),

        // New password input
        MyTextField(
          labelText: widget.passwordLabel ?? "New Password",
          hintText: "Enter your new password",
          controller: widget.passwordController,
          obscureText: true,
          keyboardType: TextInputType.text,
          prefixIcon: CupertinoIcons.lock,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your password";
            } else if (value.length < 8) {
              return "Password must be at least 8 characters long";
            }
            return null;
          },
          onChanged: _validatePassword,
        ),

        const SizedBox(height: 8),

        // Password requirements feedback
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 8,
            children: [
              _buildValidationDot(hasMinLength, "8+ characters"),
              _buildValidationDot(hasNumber, "1+ number"),
              _buildValidationDot(hasUppercase, "1+ uppercase"),
              _buildValidationDot(hasLowercase, "1+ lowercase"),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Confirm password input
        MyTextField(
          labelText: widget.confirmPasswordLabel ?? "Confirm Password",
          hintText: "Re-enter your password",
          controller: widget.confirmPasswordController,
          obscureText: true,
          keyboardType: TextInputType.text,
          prefixIcon: CupertinoIcons.lock_shield,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please confirm your password";
            } else if (value != widget.passwordController.text) {
              return "Passwords do not match";
            }
            return null;
          },
        ),
      ],
    );
  }

  // Password rule indicator (dot + label)
  Widget _buildValidationDot(bool isValid, String tooltip) {
    final color = isValid ? Colors.green : Colors.redAccent;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.circle, color: color, size: 10),
        const SizedBox(width: 4),
        Text(
          tooltip,
          style: TextStyle(fontSize: 12, color: color),
        ),
      ],
    );
  }
}
