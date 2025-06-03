import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:steet/core/constants/api_endpoints.dart';
import 'package:steet/core/utils/dio_service.dart';
import 'package:steet/data/models/student_model.dart';

class StudentDataSource {
  final DioService _dioService = DioService();


  StudentDataSource() {
    // _dioService.addInterceptors(); // Add logging and other interceptors
  }

 Future<List<StudentModel>> getStudents() async {
  try {
    final response = await _dioService.get(ApiEndpoints.students);
    print('Data received from getStudents: $response');

    if (response is List) {
      // Direct list response
      return response
          .map((student) => StudentModel.fromJson(student as Map<String, dynamic>))
          .toList();
    } else if (response is Map<String, dynamic> && response.containsKey('data')) {
      // Response wrapped in data field
      final List<dynamic> studentsData = response['data'] as List<dynamic>;
      return studentsData
          .map((student) => StudentModel.fromJson(student as Map<String, dynamic>))
          .toList();
    }

    throw Exception('Unexpected response format');
  } catch (e) {
    print('Error fetching students: $e');
    throw Exception('Failed to fetch students: $e');
  }
}

  Future<StudentModel> getStudentById(String id) async {
    try {
      final data = await _dioService
          .get(ApiEndpoints.studentById.replaceFirst('{id}', id));

      // Check if the response has a 'data' field (common API pattern)
      if (data is Map<String, dynamic> && data.containsKey('data')) {
        return StudentModel.fromJson(data['data']);
      }


      // Otherwise, use the response directly
      return StudentModel.fromJson(data);
    } catch (e) {
      print('Error in getStudentById: $e');
      throw Exception('Failed to get student: $e');
    }
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


  Future<List<int>> getStudentCount() async {
    try {
      final response = await _dioService.get(ApiEndpoints.studentCount);
      if (response is int) {
        return [response];
      } else if (response is Map<String, dynamic> &&
          response.containsKey('count')) {
        return [response['count'] as int];
      } else {
        throw Exception('Unexpected response format: $response');
      }
    } catch (e) {
      print('Error getting student count: $e');
      throw Exception('Failed to get student count: $e');
    }
  }

  Future<String> uploadProfileImage(
      String studentId, Uint8List fileBytes) async {
    try {
      final formData = FormData.fromMap({
        'studentId': studentId,
        'file': MultipartFile.fromBytes(fileBytes, filename: '$studentId.jpg'),
      });

      final response = await _dioService.post(ApiEndpoints.uploadProfileImage,
          data: formData);

      // If response is already a string, return it directly
      if (response is String) {
        print('Profile image URL: $response');
        return response;
      }

      // Check if the response has a URL field or similar
      if (response is Map<String, dynamic>) {
        // Try to extract the URL from the response based on your API structure
        if (response.containsKey('data')) {
          return response['data'] as String;
        } else if (response.containsKey('url')) {
          return response['url'] as String;
        } else if (response.containsKey('imageUrl')) {
          return response['imageUrl'] as String;
        } else {
          print('Response structure: $response');
          throw Exception('Could not extract image URL from response');
        }
      }


      // If we can't identify the response type, convert it to string
      return response.toString();
    } catch (e) {
      print('Error uploading profile image: $e');
      throw Exception('Failed to upload profile image: $e');
    }
  }

  // Rest of implementation...
}
