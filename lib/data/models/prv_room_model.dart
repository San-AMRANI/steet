import 'room_model.dart';

class PrvRoomModel extends RoomModel {
  final bool isVisible;
  final String createdBy;
  final List<String> memberships;

  PrvRoomModel({
    required super.id,
    required super.name,
    required super.description,
    required super.imageUrl,
    required super.createdAt,
    required this.isVisible,
    required this.createdBy,
    required this.memberships,
  });

  factory PrvRoomModel.fromJson(Map<String, dynamic> json) {
    return PrvRoomModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      isVisible: json['visible'] ?? false,
      createdBy: json['createdBy'],
      memberships: json['memberships'] != null 
          ? List<String>.from(json['memberships'])
          : [],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['visible'] = isVisible;
    json['createdBy'] = createdBy;
    json['memberships'] = memberships;
    json['imageUrl'] = imageUrl;
    return json;
  }
}