import 'package:steet/domain/entities/prv_room.dart';

enum InvitationStatus {
  PENDING,
  ACCEPTED,
  REJECTED
}

class Invitation {
  final String id;
  final PrvRoom room;
  final String invitedStudentId;
  final String inviterStudentId;
  final DateTime createdAt;
  final InvitationStatus status;
  final DateTime? respondedAt;

  const Invitation({
    required this.id,
    required this.room,
    required this.invitedStudentId,
    required this.inviterStudentId,
    required this.createdAt,
    required this.status,
    this.respondedAt,
  });
} 