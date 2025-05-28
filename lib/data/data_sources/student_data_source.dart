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
    final data = await _dioService.get(ApiEndpoints.students);
    final List<dynamic> studentsData = data['data'] as List<dynamic>;
    return studentsData.map((student) => StudentModel.fromJson(student)).toList();
  }
  Future<StudentModel> getStudentById(String id) async {
    try {
      final data = await _dioService.get(ApiEndpoints.studentById.replaceFirst('{id}', id));
      
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
  }  Future<String> uploadProfileImage(String studentId, Uint8List fileBytes) async {
    try {
      final formData = FormData.fromMap({
        'studentId': studentId,
        'file': MultipartFile.fromBytes(fileBytes, filename: '$studentId.jpg'),
      });

      final response = await _dioService.post(ApiEndpoints.uploadProfileImage, data: formData);
      
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