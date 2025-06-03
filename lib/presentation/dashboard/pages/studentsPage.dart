import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steet/presentation/providers/DashboardProvider.dart';

class StudentsPage extends ConsumerWidget {
  const StudentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final students = ref.watch(dashboardProvider).students;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              ref.read(dashboardProvider.notifier).fetchStudents();
            },
          ),
        ],
      ),
      body: students.isEmpty
          ? const Center(child: Text('No students found.'))
          : ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return Card(
                  
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('${student.firstName} ${student.lastName}'),
                    leading: student.profilePictureUrl == null || student.profilePictureUrl!.isEmpty
                      ? const Icon(Icons.account_circle, size: 50)
                      : CachedNetworkImage(
                        imageUrl: student.profilePictureUrl!,
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email: ${student.email}'),
                        Text('Major: ${student.major}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}