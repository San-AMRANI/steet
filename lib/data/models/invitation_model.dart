import 'package:steet/domain/entities/invitation.dart';
import 'package:steet/data/models/prv_room_model.dart';

class InvitationModel {
  final String id;
  final PrvRoomModel room;
  final String invitedStudentId;
  final String inviterStudentId;
  final DateTime createdAt;
  final InvitationStatus status;
  final DateTime? respondedAt;

  InvitationModel({
    required this.id,
    required this.room,
    required this.invitedStudentId,
    required this.inviterStudentId,
    required this.createdAt,
    required this.status,
    this.respondedAt,
  });

  factory InvitationModel.fromJson(Map<String, dynamic> json) {
    return InvitationModel(
      id: json['id'],
      room: PrvRoomModel.fromJson(json['room']),
      invitedStudentId: json['invitedStudentId'],
      inviterStudentId: json['inviterStudentId'],
      createdAt: DateTime.parse(json['createdAt']),
      status: InvitationStatus.values.firstWhere(
        (e) => e.toString() == 'InvitationStatus.${json['status']}',
      ),
      respondedAt: json['respondedAt'] != null 
          ? DateTime.parse(json['respondedAt'])
          : null,
    );
  }

  Invitation toEntity() {
    return Invitation(
      id: id,
      room: room.toEntity(),
      invitedStudentId: invitedStudentId,
      inviterStudentId: inviterStudentId,
      createdAt: createdAt,
      status: status,
      respondedAt: respondedAt,
    );
  }
} 