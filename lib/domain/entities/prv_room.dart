import 'room.dart';

class PrvRoom extends Room {
  final bool isVisible;
  final String createdBy;
  final List<String> memberships;

  PrvRoom({
    required super.id,
    required super.name,
    required super.description,
    required super.imageUrl,
    required super.createdAt,
    required this.isVisible,
    required this.createdBy,
    required this.memberships,
  });

  factory PrvRoom.fromJson(Map<String, dynamic> json) {
    return PrvRoom(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isVisible: json['isVisible'] as bool,
      createdBy: json['createdBy'] as String,
      memberships: List<String>.from(json['memberships']),
      imageUrl: json['imageUrl'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['isVisible'] = isVisible;
    json['createdBy'] = createdBy;
    json['memberships'] = memberships;
    json['imageUrl'] = imageUrl;
    return json;
  }
}