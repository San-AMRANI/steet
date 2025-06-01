import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:steet/presentation/widgets/my_select_field.dart';
import 'package:steet/presentation/widgets/my_text_field.dart';

/// A widget that displays the bottom sheet for editing additional information
class AdditionalInfoBottomSheet extends StatefulWidget {
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
  State<AdditionalInfoBottomSheet> createState() => _AdditionalInfoBottomSheetState();
}

class _AdditionalInfoBottomSheetState extends State<AdditionalInfoBottomSheet> {
  String? selectedMajor;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    selectedMajor = widget.majorController.text.isNotEmpty ? widget.majorController.text : null;
  }

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
                  setState(() {
                    widget.dobController.text =
                        "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                  });
                }
              },
              child: AbsorbPointer(
                child: MyTextField(
                  labelText: 'Date of Birth',
                  hintText: 'Enter your date of birth',
                  controller: widget.dobController,
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
            MySelectField<String>(
              labelText: 'Major',
              hintText: 'Select your major',
              prefixIcon: CupertinoIcons.book,
              value: selectedMajor,
              items: const [
                DropdownMenuItem(
                    value: 'COMPUTER_SCIENCE', child: Text('Computer Science')),
                DropdownMenuItem(
                    value: 'MATHEMATICS', child: Text('Mathematics')),
                DropdownMenuItem(value: 'PHYSICS', child: Text('Physics')),
                DropdownMenuItem(value: 'CHEMISTRY', child: Text('Chemistry')),
                DropdownMenuItem(value: 'BIOLOGY', child: Text('Biology')),
                DropdownMenuItem(value: 'HISTORY', child: Text('History')),
                DropdownMenuItem(value: 'ART', child: Text('Art')),
              ],
              onChanged: (value) {
                setState(() {
                  selectedMajor = value;
                  widget.majorController.text = value ?? '';
                  _errorMessage = null;
                });
              },
              errorMsg: _errorMessage,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a major';
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
                    if (widget.formKey.currentState?.validate() ?? false) {
                      widget.onSave();
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
