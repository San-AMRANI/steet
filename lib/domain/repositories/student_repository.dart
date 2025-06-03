import 'dart:ffi';
import 'dart:typed_data';

import 'package:steet/domain/entities/student.dart';

abstract class StudentRepository {
  Future<List<Student>> getStudents();
  Future<Student?> getStudentById(String id);
  Future<Student?> updateStudent(Student student);
  Future<List<Student>> searchStudents(String query);
  // Future<Student?> getStudentByEmail(String email);
  // Future<Student?> getStudentByUserName(String userName);
  // Future<void> addStudent(Student student);

  Future<String> uploadProfileImage(String studentId, Uint8List fileBytes);
  Future<List<int>> GetStudentCount();
}

