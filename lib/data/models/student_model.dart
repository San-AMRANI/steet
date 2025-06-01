import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../domain/entities/student.dart';

class StudentModel {
  final String id;
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final DateTime dob;
  final String major;
  final String? profilePictureUrl;
  
  StudentModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.dob,
    required this.major,
    this.profilePictureUrl,
  });

  static String? buildProfilePictureUrl(String? rawUrl) {
    if (rawUrl == null) return null;
    final baseUrl = dotenv.env['BASE_URL'] ?? '';
    return baseUrl + rawUrl;
  }

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      userName: json['userName'] as String,
      email: json['email'] as String,
      dob: DateTime.parse(json['dob'] as String),
      major: json['major'] as String,
      profilePictureUrl: buildProfilePictureUrl(json['profilePictureUrl'] as String?),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'email': email,
      'dob': dob.toIso8601String(),
      'major': major,
      'profilePictureUrl': profilePictureUrl?.replaceFirst(dotenv.env['BASE_URL']!, ''),
    };
  }

  Student toEntity() {
    return Student(
      id: id,
      firstName: firstName,
      lastName: lastName,
      userName: userName,
      email: email,
      dob: dob,
      major: major,
      profilePictureUrl: profilePictureUrl,
    );
  }

  @override
  String toString() {
    return 'StudentModel{id: $id, firstName: $firstName, lastName: $lastName, userName: $userName, email: $email, dob: $dob, major: $major, profilePictureUrl: $profilePictureUrl}';
  }
}
