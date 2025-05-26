import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:steet/presentation/widgets/my_text_field.dart';

/// A widget that displays the bottom sheet for editing additional information
class AdditionalInfoBottomSheet extends StatelessWidget {
  final TextEditingController dobController;
  final TextEditingController majorController;
  final GlobalKey<FormState> formKey;
  final VoidCallback onSave;

  const AdditionalInfoBottomSheet({
    super.key,
    required this.dobController,
    required this.majorController,
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
                'Edit Additional Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1980),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  dobController.text =
                      "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                }
              },
              child: AbsorbPointer(
                child: MyTextField(
                  labelText: 'Date of Birth',
                  hintText: 'Enter your date of birth',
                  controller: dobController,
                  obscureText: false,
                  keyboardType: TextInputType.datetime,
                  prefixIcon: CupertinoIcons.calendar,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Date of birth is required';
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            MyTextField(
              labelText: 'Major',
              hintText: 'Enter your major',
              controller: majorController,
              obscureText: false,
              keyboardType: TextInputType.text,
              prefixIcon: CupertinoIcons.book,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Major is required';
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
