import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steet/data/data_sources/mock_student_data_source.dart';
import 'package:steet/data/repositories/student_repository_imp.dart';
import 'package:steet/domain/entities/student.dart';

// TODO: Switch to real data source in production
final _dataSource = MockStudentDataSource();
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

// Search provider
final studentSearchProvider =
    StateNotifierProvider<StudentSearchNotifier, AsyncValue<List<Student>>>(
        (ref) {
  return StudentSearchNotifier(_repository);
});

class StudentSearchNotifier extends StateNotifier<AsyncValue<List<Student>>> {
  final StudentRepositoryImp _repository;

  StudentSearchNotifier(this._repository) : super(const AsyncValue.data([]));

  void clearResults() {
    state = const AsyncValue.data([]);
  }

  Future<void> searchStudents(String query) async {
    print('Provider: received search query: "$query"'); // Debug print

    if (query.isEmpty) {
      print('Provider: empty query, returning empty list'); // Debug print
      state = const AsyncValue.data([]);
      return;
    }

    try {
      print('Provider: searching for "$query"'); // Debug print
      state = const AsyncValue.loading();
      final students = await _repository.searchStudents(query);
      print('Provider: found ${students.length} results'); // Debug print
      if (!mounted) {
        print('Provider: not mounted, skipping update'); // Debug print
        return;
      }
      state = AsyncValue.data(students);
    } catch (e, stack) {
      print('Provider: search failed with error: $e'); // Debug print
      state = AsyncValue.error(e, stack);
    }
  }
}
