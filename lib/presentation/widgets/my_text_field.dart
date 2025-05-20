import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final String? errorMsg;
  final ValueChanged<String>? onChanged;

  const MyTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    required this.obscureText,
    required this.keyboardType,
    this.suffixIcon,
    this.onTap,
    this.prefixIcon,
    this.validator,
    this.focusNode,
    this.errorMsg,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      focusNode: focusNode,
      onTap: onTap,
      onChanged: onChanged,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Icon(
                  prefixIcon,
                ),
              )
            : null,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        labelText: labelText,
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: .5),
          fontSize: 14,
        ),
        errorText: errorMsg,
        errorStyle: const TextStyle(fontSize: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: .5),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 1.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 2,
          ),
        ),
      ),
      validator: validator,
    );
  }
}