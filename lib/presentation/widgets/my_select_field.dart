import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySelectField<T> extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData? prefixIcon;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final String? errorMsg;
  final FormFieldValidator<T>? validator;

  const MySelectField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.items,
    required this.value,
    required this.onChanged,
    this.prefixIcon,
    this.errorMsg,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: DropdownButtonFormField<T>(
        value: value,
        items: items,
        onChanged: onChanged,
        icon: const Icon(CupertinoIcons.chevron_down),
        iconSize: 24,
        elevation: 2,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 16,
        ),
        decoration: InputDecoration(
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
        dropdownColor: Theme.of(context).colorScheme.surface,
        
      ),
    );
  }
}