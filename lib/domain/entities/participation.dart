import 'package:steet/data/models/participation_model.dart';

class Participation {
  final String id;
  final String idStudent;
  final DateTime joinedAt;
  final DateTime? leftAt;

  Participation({
    required this.id,
    required this.idStudent,
    required this.joinedAt,
    this.leftAt,
  });

  factory Participation.fromJson(Map<String, dynamic> json) {
    return Participation(
      id: json['id'] as String,
      idStudent: json['id_student'] as String,
      joinedAt: DateTime.parse(json['joinedAt']),
      leftAt: json['leftAt'] != null ? DateTime.parse(json['leftAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_student': idStudent,
      'joinedAt': joinedAt.toIso8601String(),
      if (leftAt != null) 'leftAt': leftAt!.toIso8601String(),
    };
  }

  ParticipationModel toModel() {
    return ParticipationModel(
      id: id,
      idStudent: idStudent,
      joinedAt: joinedAt,
      leftAt: leftAt,
    );
  }
}
