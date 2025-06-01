import 'package:steet/domain/repositories/student_repository.dart';

import '../entities/student.dart';

class GetStudents{
  final StudentRepository studentRepository;

  GetStudents({required this.studentRepository});

  Future<List<Student>> execute() async {
    return await studentRepository.getStudents();
  }
  
}

class GetStudentById {
  final StudentRepository studentRepository;

  GetStudentById({required this.studentRepository});

  Future<Student?> execute(String id) async {
    return await studentRepository.getStudentById(id);
  }
}