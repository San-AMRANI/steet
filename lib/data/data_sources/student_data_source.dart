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
  
  // Rest of implementation...
}