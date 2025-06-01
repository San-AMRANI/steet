import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'my_text_field.dart';

class NewPasswordWidget extends StatefulWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  final GlobalKey<FormState> formKey;

  final String title;
  final bool showOldPassword;

  final String? passwordLabel;
  final String? confirmPasswordLabel;

  // Static method for external validation
  static bool isPasswordValid(String password) {
    return password.length >= 8 &&
           password.contains(RegExp(r'[0-9]')) &&
           password.contains(RegExp(r'[A-Z]')) &&
           password.contains(RegExp(r'[a-z]'));
  }

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
  bool passwordsMatch = false;

  void _validatePassword(String password) {
    setState(() {
      hasMinLength = password.length >= 8;
      hasNumber = password.contains(RegExp(r'[0-9]'));
      hasUppercase = password.contains(RegExp(r'[A-Z]'));
      hasLowercase = password.contains(RegExp(r'[a-z]'));
    });
    _validatePasswordConfirmation();
  }

  void _validatePasswordConfirmation() {
    setState(() {
      passwordsMatch = widget.passwordController.text == widget.confirmPasswordController.text &&
          widget.confirmPasswordController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    // Initialize validation state
    _validatePassword(widget.passwordController.text);
    
    // Listen to changes in both password fields
    widget.passwordController.addListener(() {
      _validatePassword(widget.passwordController.text);
    });
    
    widget.confirmPasswordController.addListener(() {
      _validatePasswordConfirmation();
    });
  }

  @override
  void dispose() {
    // Don't dispose the controllers here, they're passed from parent
    super.dispose();
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
            } 
            
            // Check all password requirements in validator
            if (!hasMinLength) {
              return "Password must be at least 8 characters long";
            } 
            if (!hasNumber) {
              return "Password must contain at least one number";
            } 
            if (!hasUppercase) {
              return "Password must contain at least one uppercase letter";
            } 
            if (!hasLowercase) {
              return "Password must contain at least one lowercase letter";
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

        // Confirm password input with comprehensive validation
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
            } 
            if (value != widget.passwordController.text) {
              return "Passwords do not match";
            }
            // Only validate match if we have a value
            return null;
          },
          onChanged: (_) => _validatePasswordConfirmation(),
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