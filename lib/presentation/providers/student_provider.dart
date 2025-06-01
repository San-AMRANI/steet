import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steet/data/data_sources/mock_student_data_source.dart';
import 'package:steet/data/data_sources/student_data_source.dart';
import 'package:steet/data/repositories/student_repository_imp.dart';
import 'package:steet/domain/entities/student.dart';

// final _dataSource = StudentDataSource();
final _dataSource = MockStudentDataSource(); // Use your actual data source here
final _repository = StudentRepositoryImp(dataSource: _dataSource);

final studentProvider =
    FutureProvider.autoDispose.family<Student?, String>((ref, id) async {
  return _repository.getStudentById(id);
});

final studentsProvider = FutureProvider.autoDispose<List<Student>>((ref) async {
  return _repository.getStudents();
});

final updateStudentProvider =
    FutureProvider.autoDispose.family<Student?, Student>((ref, student) async {
  return _repository.updateStudent(student);
});
