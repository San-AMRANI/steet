import 'dart:typed_data';

import 'package:steet/domain/entities/student.dart';
import 'package:steet/domain/repositories/student_repository.dart';
import 'package:steet/data/data_sources/student_data_source.dart';

class StudentRepositoryImp implements StudentRepository {
  final StudentDataSource dataSource;
  StudentRepositoryImp({required this.dataSource});

  @override
  Future<List<Student>> getStudents() async {
    final studentModels = await dataSource.getStudents();
    return studentModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<Student?> getStudentById(String id) async {
    try {
      final studentModel = await dataSource.getStudentById(id);
      return studentModel.toEntity();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Student?> updateStudent(Student student) async {
    try {
      final studentModel = await dataSource.updateStudent(student.toModel());
      return studentModel.toEntity();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Student>> searchStudents(String query) async {
    try {
      final studentModels = await dataSource.searchStudents(query);
      return studentModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<String> uploadProfileImage(String studentId, Uint8List fileBytes) async {
    try {
      return await dataSource.uploadProfileImage(studentId, fileBytes);
    } catch (e) {
      throw Exception('Failed to upload profile image: $e');
    }
  }
  // @override
  // Future<Student?> getStudentByEmail(String email) async {
  //   try {
  //     final studentModel = await dataSource.getStudentByEmail(email);
  //     return studentModel.toEntity();
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // @override
  // Future<Student?> getStudentByUserName(String userName) async {
  //   try {
  //     final studentModel = await dataSource.getStudentByUsername(userName);
  //     return studentModel.toEntity();
  //   } catch (e) {
  //     return null;
  //   }
  // }
}
