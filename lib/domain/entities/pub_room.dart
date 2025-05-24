import 'room.dart';
import 'participation.dart';

class PubRoom extends Room {
  final List<Participation> participation;

  PubRoom({
    required super.id,
    required super.name,
    required super.description,
    required super.imageUrl,
    required super.createdAt,
    required this.participation,
  });

  factory PubRoom.fromJson(Map<String, dynamic> json) {
    return PubRoom(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      participation: (json['participation'] as List<dynamic>)
          .map((p) => Participation(
                id: p['id'] as String,
                idStudent: p['id_student'] as String,
                joinedAt: DateTime.parse(p['joinedAt']),
                leftAt: p['leftAt'] != null ? DateTime.parse(p['leftAt']) : null,
              ))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['participation'] = participation
        .map((p) => {
              'id': p.id,
              'id_student': p.idStudent,
              'joinedAt': p.joinedAt.toIso8601String(),
              if (p.leftAt != null) 'leftAt': p.leftAt!.toIso8601String(),
            })
        .toList();
    return json;
  }
}