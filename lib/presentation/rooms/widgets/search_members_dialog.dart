import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steet/domain/entities/student.dart';
import 'package:steet/presentation/providers/student_provider_new.dart';
import 'package:steet/presentation/widgets/my_text_field.dart';

class SearchMembersDialog extends ConsumerStatefulWidget {
  final Function(List<Student>) onMembersSelected;
  final List<Student> initialSelection;

  const SearchMembersDialog({
    Key? key,
    required this.onMembersSelected,
    required this.initialSelection,
  }) : super(key: key);

  @override
  ConsumerState<SearchMembersDialog> createState() =>
      _SearchMembersDialogState();
}

class _SearchMembersDialogState extends ConsumerState<SearchMembersDialog> {
  final TextEditingController _searchController = TextEditingController();
  late final Set<Student> _selectedStudents;
  Timer? _debounceTimer;

  Widget _buildListTile(Student student, bool isSelected) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage:
            student.imageUrl != null ? NetworkImage(student.imageUrl!) : null,
        child: student.imageUrl == null ? Text(student.firstName[0]) : null,
      ),
      title: Text(student.fullName),
      subtitle: Text(student.email),
      trailing: Checkbox(
        value: isSelected,
        onChanged: (bool? value) {
          setState(() {
            if (value == true) {
              _selectedStudents.add(student);
            } else {
              _selectedStudents.removeWhere((s) => s.id == student.id);
            }
            // Notify parent of the change immediately
            widget.onMembersSelected(_selectedStudents.toList());
          });
        },
      ),
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedStudents.removeWhere((s) => s.id == student.id);
          } else {
            _selectedStudents.add(student);
          }
          // Notify parent of the change immediately
          widget.onMembersSelected(_selectedStudents.toList());
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _selectedStudents = Set<Student>.from(widget.initialSelection);
    // Clear any existing search results on init
    // ref.read(studentSearchProvider.notifier).clearResults();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (value.trim().isNotEmpty) {
      _debounceTimer = Timer(const Duration(milliseconds: 300), () {
        if (mounted) {
          // Pass selected students to exclude them from search results
          ref.read(studentSearchProvider.notifier).searchStudents(
                value,
              );
        }
      });
    } else {
      ref.read(studentSearchProvider.notifier).clearResults();
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(studentSearchProvider);

    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            const Text(
              'Add people',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            // Search field with icon
            MyTextField(
              controller: _searchController,
              labelText: 'Search',
              hintText: 'Find people',
              onChanged: _onSearchChanged,
              prefixIcon: Icons.search,
              keyboardType: TextInputType.text,
              obscureText: false,
            ),
            const SizedBox(height: 16), // Results list
            Expanded(
              child: Builder(
                builder: (context) {
                  // When search field is empty, show only selected members
                  if (_searchController.text.isEmpty) {
                    if (_selectedStudents.isEmpty) {
                      return const Center(
                        child: Text('Start typing to search...'),
                      );
                    }
                    return ListView.builder(
                      itemCount: _selectedStudents.length,
                      itemBuilder: (context, index) {
                        final student = _selectedStudents.elementAt(index);
                        return _buildListTile(student, true);
                      },
                    );
                  }

                  // When searching, show search results with proper selection state
                  return searchState.when(
                    data: (students) {
                      if (students.isEmpty) {
                        return const Center(
                          child: Text('No results found'),
                        );
                      }

                      return ListView.builder(
                        itemCount: students.length,
                        itemBuilder: (context, index) {
                          final student = students[index];
                          // Now this will work correctly with the proper equality implementation
                          final isSelected = _selectedStudents.any((s) => s.id == student.id);
                          return _buildListTile(student, isSelected);
                        },
                      );
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (error, stack) => Center(
                      child: Text('Error: $error'),
                    ),
                  );
                },
              ),
            ),

            // Bottom buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  onPressed: () {
                    // Always call onMembersSelected with current selection before closing
                    widget.onMembersSelected(_selectedStudents.toList());
                    Navigator.pop(context);
                  },
                  child: Text(
                    _selectedStudents.isEmpty ? 'Close' : 'Done (${_selectedStudents.length})',
                    style: const TextStyle(fontSize: 16)
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
