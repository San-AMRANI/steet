import 'package:steet/domain/entities/student.dart';
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
