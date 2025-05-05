import '../../domain/entities/student.dart';

class StudentModel extends Student {
  StudentModel({
    required String id,
    required String firstName,
    required String lastName,
    required String userName,
    required String email,
    required DateTime dob,
    required String major,
  }) : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
          userName: userName,
          email: email,
          dob: dob,
          major: major,
        );

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      userName: json['userName'] as String,
      email: json['email'] as String,
      dob: DateTime.parse(json['dob'] as String),
      major: json['major'] as String,
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
    };
  }
}