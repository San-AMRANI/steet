import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steet/data/data_sources/student_data_source.dart';
import 'package:steet/data/models/student_model.dart';
import 'package:steet/data/repositories/student_repository_imp.dart';
import 'package:steet/domain/entities/student.dart';
import 'package:steet/domain/repositories/student_repository.dart';

// Create a state class to represent the student data state
class StudentState {
  final Student? student;
  final List<Student> students;
  final bool isLoading;
  final String? error;

  const StudentState({
    this.student,
    this.students = const [],
    this.isLoading = false,
    this.error,
  });

  StudentState copyWith({
    Student? student,
    List<Student>? students,
    bool? isLoading,
    String? error,
  }) {
    return StudentState(
      student: student ?? this.student,
      students: students ?? this.students,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

// Create a notifier class to handle student operations
class StudentNotifier extends Notifier<StudentState> {
  late final StudentRepositoryImp _repository;

  @override
  StudentState build() {
    _repository = StudentRepositoryImp(dataSource: StudentDataSource());
    return const StudentState();
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
final studentNotifierProvider =
    NotifierProvider<StudentNotifier, StudentState>(() {
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

// final studentRepositoryProvider = Provider<StudentRepository>((ref) {
//   return StudentRepositoryImp(dataSource: StudentDataSource());
// });

// final studentsProvider = FutureProvider<List<Student>>((ref) async {
//   final repository = ref.watch(studentRepositoryProvider);
//   return repository.getStudents();
// });

// final studentByIdProvider =
//     FutureProvider.family<Student?, String>((ref, id) async {
//   final repository = ref.watch(studentRepositoryProvider);
//   return repository.getStudentById(id);
// });
