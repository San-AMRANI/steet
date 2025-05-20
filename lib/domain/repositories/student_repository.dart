import 'package:steet/domain/entities/student.dart';

abstract class StudentRepository {
  Future<List<Student>> getStudents();
  // Future<Student?> getStudentById(String id);
  // Future<Student?> getStudentByEmail(String email);
  // Future<Student?> getStudentByUserName(String userName);
  // Future<void> addStudent(Student student);
  // Future<void> updateStudent(Student student);
  // Future<void> deleteStudent(String id);
}