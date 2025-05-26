import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' show CupertinoIcons; 

/// A widget that displays a section with a title and edit button
class InfoSection extends StatelessWidget {
  final String title;
  final VoidCallback onEditPressed;
  final List<Widget> children;

  const InfoSection({
    super.key,
    required this.title,
    required this.onEditPressed,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: const Icon(CupertinoIcons.pencil),
              onPressed: onEditPressed,
              color: Colors.black,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
