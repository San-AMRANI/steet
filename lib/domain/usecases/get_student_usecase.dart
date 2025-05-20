import 'package:steet/domain/repositories/student_repository.dart';

import '../entities/student.dart';

class GetStudents{
  final StudentRepository studentRepository;

  GetStudents({required this.studentRepository});

  Future<List<Student>> execute() async {
    return await studentRepository.getStudents();
  }
}
