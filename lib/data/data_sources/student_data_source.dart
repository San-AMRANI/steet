import 'package:steet/core/constants/api_endpoints.dart';
import 'package:steet/core/utils/dio_service.dart';
import 'package:steet/data/models/student_model.dart';

class StudentDataSource {
  final DioService _dioService = DioService();

  StudentDataSource() {
    // _dioService.addInterceptors(); // Add logging and other interceptors
  }

 Future<List<StudentModel>> getStudents() async {
  final List<dynamic> studentsData = await _dioService.get(ApiEndpoints.students);
  return studentsData.map((student) => StudentModel.fromJson(student)).toList();
}

  Future<StudentModel> getStudentById(String id) async {
    final data = await _dioService
        .get(ApiEndpoints.studentById.replaceFirst('{id}', id));
    return StudentModel.fromJson(data);
  }

  Future<StudentModel> updateStudent(StudentModel student) async {
    final data = await _dioService.put(
      ApiEndpoints.createUpdateStudent,
      data: student.toJson(),
    );

    return StudentModel.fromJson(data);
  }

  Future<List<StudentModel>> searchStudents(String query) async {
    try {
      final response = await _dioService.get(
        '${ApiEndpoints.students}/search',
        queryParameters: {
          'q': query,
        },
      );

      final List<dynamic> studentsData = response['data'] as List<dynamic>;
      return studentsData.map((json) => StudentModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to search students: $e');
    }
  }
  // Rest of implementation...
}
