import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steet/data/data_sources/student_data_source.dart';
import 'package:steet/data/models/student_model.dart';
import 'package:steet/data/repositories/student_repository_imp.dart';
import 'package:steet/domain/entities/student.dart';
import 'package:steet/presentation/providers/states/student_state.dart';

// Create a notifier class to handle student operations
class StudentNotifier extends StateNotifier<StudentState> {
  late final StudentRepositoryImp _repository;

  StudentNotifier() : super(const StudentState()) {
    _repository = StudentRepositoryImp(dataSource: StudentDataSource());
  }

  // Get a student by ID
  Future<void> getStudentById(String id) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final student = await _repository.getStudentById(id);
      state = state.copyWith(student: student, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  // Get all students
  Future<void> getStudents() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final students = await _repository.getStudents();
      state = state.copyWith(students: students, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  // Update a student
  Future<void> updateStudent(Student student) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final updatedStudent = await _repository.updateStudent(student);
      state = state.copyWith(student: updatedStudent, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
  
  // Upload a profile image
  Future<String?> uploadProfileImage(
      String studentId, Uint8List imageBytes) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final imageUrl =
          await _repository.uploadProfileImage(studentId, imageBytes);

      // If we have the current student loaded and it matches the ID, update the profile URL
      if (state.student != null && state.student!.id == studentId) {
        final updatedStudent = state.student!.copyWith(
            profilePictureUrl: StudentModel.buildProfilePictureUrl(imageUrl));

        state = state.copyWith(student: updatedStudent, isLoading: false);
      } else {
        state = state.copyWith(isLoading: false);
      }

      return imageUrl;
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
      return null;
    }
  }
}

// Create the provider
final studentNotifierProvider = StateNotifierProvider<StudentNotifier, StudentState>((ref) {
  return StudentNotifier();
});

// Convenience providers for common operations
final currentStudentProvider = Provider<Student?>((ref) {
  return ref.watch(studentNotifierProvider).student;
});

final studentsListProvider = Provider<List<Student>>((ref) {
  return ref.watch(studentNotifierProvider).students;
});

final studentErrorProvider = Provider<String?>((ref) {
  return ref.watch(studentNotifierProvider).error;
});

final isLoadingStudentProvider = Provider<bool>((ref) {
  return ref.watch(studentNotifierProvider).isLoading;
});
