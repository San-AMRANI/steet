
import 'package:steet/data/models/student_model.dart';

class Student {
  final String id;
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final DateTime dob;
  final String major;

  Student({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.dob,
    required this.major,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
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
      'dob': dob,
      'major': major,
    };
  }

  

  StudentModel toModel() {
    return StudentModel(
      id: id,
      firstName: firstName,
      lastName: lastName,
      userName: userName,
      email: email,
      dob: dob,
      major: major,
    );
  }

  @override
  String toString() {
    return 'Student{id: $id, firstName: $firstName, lastName: $lastName, userName: $userName, email: $email, dob: $dob, major: $major}';
  }
}