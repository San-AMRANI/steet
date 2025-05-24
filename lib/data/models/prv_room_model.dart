import 'room_model.dart';

class PrvRoomModel extends RoomModel {
  final bool isPrivate;
  final String createdBy;
  final List<String> memberships;

  PrvRoomModel({
    required super.id,
    required super.name,
    required super.description,
    required super.imageUrl,
    required super.createdAt,
    required this.isPrivate,
    required this.createdBy,
    required this.memberships,
  });

  factory PrvRoomModel.fromJson(Map<String, dynamic> json) {
    return PrvRoomModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
      isPrivate: json['isPrivate'],
      createdBy: json['createdBy'],
      memberships: List<String>.from(json['memberships']),
      imageUrl: json['imageUrl'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['isPrivate'] = isPrivate;
    json['createdBy'] = createdBy;
    json['memberships'] = memberships;
    json['imageUrl'] = imageUrl;
    return json;
  }
}