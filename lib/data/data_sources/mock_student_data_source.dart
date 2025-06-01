import 'package:steet/data/models/student_model.dart';

class MockStudentDataSource {
  final List<StudentModel> _mockStudents = [
    StudentModel(
      id: '1',
      firstName: 'John',
      lastName: 'Doe',
      userName: 'johndoe',
      email: 'john.doe@example.com',
      dob: DateTime(2000, 1, 1),
      major: 'Computer Science',
      imageUrl: 'https://i.pravatar.cc/150?img=1',
    ),
    StudentModel(
      id: '2',
      firstName: 'Jane',
      lastName: 'Smith',
      userName: 'janesmith',
      email: 'jane.smith@example.com',
      dob: DateTime(2001, 2, 15),
      major: 'Data Science',
      imageUrl: 'https://i.pravatar.cc/150?img=2',
    ),
    StudentModel(
      id: '3',
      firstName: 'Michael',
      lastName: 'Johnson',
      userName: 'michaelj',
      email: 'michael.j@example.com',
      dob: DateTime(1999, 7, 30),
      major: 'Software Engineering',
      imageUrl: 'https://i.pravatar.cc/150?img=3',
    ),
    StudentModel(
      id: '4',
      firstName: 'Emily',
      lastName: 'Brown',
      userName: 'emilyb',
      email: 'emily.b@example.com',
      dob: DateTime(2002, 4, 12),
      major: 'Information Systems',
      imageUrl: 'https://i.pravatar.cc/150?img=4',
    ),
    StudentModel(
      id: '5',
      firstName: 'David',
      lastName: 'Wilson',
      userName: 'davidw',
      email: 'david.w@example.com',
      dob: DateTime(2000, 9, 25),
      major: 'Artificial Intelligence',
      imageUrl: 'https://i.pravatar.cc/150?img=5',
    ),
  ];

  Future<List<StudentModel>> getStudents() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockStudents;
  }

  Future<StudentModel> getStudentById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final student = _mockStudents.firstWhere(
      (s) => s.id == id,
      orElse: () => throw Exception('Student not found'),
    );
    return student;
  }

  Future<StudentModel> updateStudent(StudentModel student) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _mockStudents.indexWhere((s) => s.id == student.id);
    if (index == -1) {
      throw Exception('Student not found');
    }
    _mockStudents[index] = student;
    return student;
  }

  Future<List<StudentModel>> searchStudents(String query) async {
    // Only search if we have at least 2 characters
    if (query.length < 2) {
      return [];
    }

    // Convert query to lowercase for case-insensitive search
    final lowercaseQuery = query.toLowerCase();

    // Search through the mock data
    return _mockStudents
        .where((student) =>
            student.firstName.toLowerCase().startsWith(lowercaseQuery) ||
            student.lastName.toLowerCase().startsWith(lowercaseQuery) ||
            // Also match full name from the start of either part
            '${student.firstName} ${student.lastName}'
                .toLowerCase()
                .split(' ')
                .any(
                  (part) => part.startsWith(lowercaseQuery),
                ))
        .toList();
  }
}
