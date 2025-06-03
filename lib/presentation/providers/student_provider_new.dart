import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steet/data/data_sources/student_data_source.dart';
import 'package:steet/data/repositories/student_repository_imp.dart';
import 'package:steet/domain/entities/student.dart';

final _dataSource = StudentDataSource();
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
  List<Student>? _cachedStudents;

  StudentSearchNotifier(this._repository) : super(const AsyncValue.data([]));

  void clearResults() {
    state = const AsyncValue.data([]);
    _cachedStudents = null;
  }

  Future<void> _fetchAndCacheStudents() async {
    if (_cachedStudents != null) return;

    try {
      print('Provider: Fetching all students for cache');
      _cachedStudents = await _repository.getStudents();
      print('Provider: Cached ${_cachedStudents?.length} students');
    } catch (e, stack) {
      print('Provider: Failed to fetch students: $e');
      throw Exception('Failed to fetch students: $e');
    }
  }

  Future<void> searchStudents(String query) async {
    print('Provider: received search query: "$query"');

    if (query.isEmpty) {
      print('Provider: empty query, returning empty list');
      state = const AsyncValue.data([]);
      return;
    }

    try {
      state = const AsyncValue.loading();

      // Fetch students if not cached
      if (_cachedStudents == null) {
        await _fetchAndCacheStudents();
      }

      if (_cachedStudents == null) {
        throw Exception('Failed to load students');
      }

      // Perform client-side search
      final lowercaseQuery = query.toLowerCase();
      final results = _cachedStudents!.where((student) {
        final fullName =
            '${student.firstName} ${student.lastName}'.toLowerCase();
        final email = student.email.toLowerCase();
        final userName = student.userName.toLowerCase();

        return fullName.contains(lowercaseQuery) ||
            email.contains(lowercaseQuery) ||
            userName.contains(lowercaseQuery) ||
            student.firstName.toLowerCase().contains(lowercaseQuery) ||
            student.lastName.toLowerCase().contains(lowercaseQuery);
      }).toList();

      print('Provider: found ${results.length} results for query: "$query"');

      if (!mounted) {
        print('Provider: not mounted, skipping update');
        return;
      }

      state = AsyncValue.data(results);
    } catch (e, stack) {
      print('Provider: search failed with error: $e');
      state = AsyncValue.error(e, stack);
    }
  }

  // Method to force refresh the cache
  Future<void> refreshCache() async {
    _cachedStudents = null;
    if (state.value?.isNotEmpty == true) {
      // If we were showing results, refresh them
      final currentQuery =
          state.value?.isNotEmpty == true ? 'current_query' : '';
      await searchStudents(currentQuery);
    }
  }
}
