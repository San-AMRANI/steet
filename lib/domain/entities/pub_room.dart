import 'room.dart';

class PubRoom extends Room {
  final List<String> participation;

  PubRoom({
    required String id,
    required String name,
    required String description,
    required DateTime createdAt,
    required this.participation,
  }) : super(
          id: id,
          name: name,
          description: description,
          createdAt: createdAt,
        );

  factory PubRoom.fromJson(Map<String, dynamic> json) {
    return PubRoom(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      participation: List<String>.from(json['participation']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['participation'] = participation;
    return json;
  }
}