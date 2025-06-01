import 'package:steet/data/models/student_model.dart';

class Student {
  final String id;
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final DateTime dob;
  final String major;
  final String? profilePictureUrl;

  Student({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.dob,
    required this.major,
    this.profilePictureUrl,
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
      profilePictureUrl: json['profilePictureUrl'] as String?,
    );
  }

  Student copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? userName,
    String? email,
    DateTime? dob,
    String? major,
    String? profilePictureUrl,
  }) {
    return Student(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      dob: dob ?? this.dob,
      major: major ?? this.major,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
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
      profilePictureUrl: profilePictureUrl,
      email: email,
      dob: dob,
      major: major,
      
    );
  }

  @override
  String toString() {
    return 'Student{id: $id, firstName: $firstName, lastName: $lastName, userName: $userName, email: $email, dob: $dob, major: $major, profilePictureUrl: $profilePictureUrl}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Student && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  String get fullName => '$firstName $lastName';
}
