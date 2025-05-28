import 'package:flutter/material.dart';

class MyTextIconButton extends StatelessWidget {
  final String text;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback onPressed;
  final Color? color;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final BorderSide? border;
  final double borderRadius;
  final bool isFullWidth;

  const MyTextIconButton({
    super.key,
    required this.text,       
    required this.prefixIcon,
    this.suffixIcon,
    required this.onPressed,
    this.color,
    this.textStyle,
    this.padding,
    this.border,
    this.borderRadius = 8.0,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final content = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(prefixIcon, color: textStyle?.color),
            const SizedBox(width: 12),
            Text(text, style: textStyle ?? const TextStyle(fontSize: 16)),
          ],
        ),
        if (suffixIcon != null)
          Icon(suffixIcon, color: textStyle?.color),
      ],
    );

    // Always use SizedBox for full width if isFullWidth is true
    if (isFullWidth) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Theme.of(context).colorScheme.surface,
            foregroundColor: textStyle?.color ?? Colors.black,
            elevation: 0,
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: border ?? BorderSide.none,
            ),
          ),
          child: content,
        ),
      );
    }
    return IntrinsicWidth(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Theme.of(context).colorScheme.surface,
          foregroundColor: textStyle?.color ?? Colors.black,
          elevation: 0,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: border ?? BorderSide.none,
          ),
        ),
        child: content,
      ),
    );
  }

}
