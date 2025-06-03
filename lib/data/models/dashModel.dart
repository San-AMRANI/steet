import 'package:steet/domain/entities/prv_room.dart';
import 'package:steet/domain/entities/pub_room.dart';
import 'package:steet/domain/entities/student.dart';

class DashModel {
  final List<PubRoom> pubRooms;
  final List<PrvRoom> prvRooms;
  final List<Student> students;

  DashModel({
    required this.pubRooms,
    required this.prvRooms,
    required this.students,
  });
}
