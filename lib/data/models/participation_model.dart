import 'package:steet/domain/entities/participation.dart';

class ParticipationModel {
  final String id;
  final String idStudent;
  final DateTime joinedAt;
  final DateTime? leftAt;

  ParticipationModel({
    required this.id,
    required this.idStudent,
    required this.joinedAt,
    this.leftAt,
  });

  factory ParticipationModel.fromJson(Map<String, dynamic> json) {
    return ParticipationModel(
      id: json['id'].toString(),
      idStudent: json['id_student'].toString(),
      joinedAt: DateTime.parse(json['joinedAt']),
      leftAt: json['leftAt'] != null ? DateTime.parse(json['leftAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_student': idStudent,
      'joinedAt': joinedAt.toIso8601String(),
      'leftAt': leftAt?.toIso8601String(),
    };
  }

  Participation toEntity() {
    return Participation(
      id: id,
      idStudent: idStudent,
      joinedAt: joinedAt,
      leftAt: leftAt,
    );
  }
}
