import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:steet/data/graphql/operations.dart';
import 'package:steet/data/models/student_model.dart';
import '../../core/utils/graphql_service.dart';

abstract class StudentDataSource {
  Future<List<StudentModel>> getStudents();
  Future<StudentModel> getStudentById(String id);
  Future<StudentModel> getStudentByEmail(String email);
  Future<StudentModel> getStudentByUsername(String username);
  // Future<void> addStudent(StudentModel student);
  // Future<void> updateStudent(StudentModel student);
  // Future<void> deleteStudent(String id);
}

class GraphQLStudentDataSource  implements StudentDataSource {
  final GraphQLService _graphqlService = GraphQLService();

  @override
  Future<List<StudentModel>> getStudents() async {
    final QueryResult result = await _graphqlService.query(GraphQLOperations.getStudents);
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
    final List<dynamic> data = result.data?['students'] as List<dynamic>;
    return data.map((student) => StudentModel.fromJson(student)).toList();
  }

  @override
  Future<StudentModel> getStudentById(String id) async {
    final QueryResult result = await _graphqlService.query(GraphQLOperations.getStudentById, variables: {'id': id});
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
    final Map<String, dynamic> data = result.data?['student'] as Map<String, dynamic>;
    return StudentModel.fromJson(data);
  }

  @override
  Future<StudentModel> getStudentByEmail(String email) async {
    final QueryResult result = await _graphqlService.query(GraphQLOperations.getStudentByEmail, variables: {'email': email});
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
    final Map<String, dynamic> data = result.data?['student'] as Map<String, dynamic>;
    return StudentModel.fromJson(data);
  }

  @override
  Future<StudentModel> getStudentByUsername(String username) async {
    final QueryResult result = await _graphqlService.query(GraphQLOperations.getStudentByUsername, variables: {'username': username});
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
    final Map<String, dynamic> data = result.data?['student'] as Map<String, dynamic>;
    return StudentModel.fromJson(data);
  }

}