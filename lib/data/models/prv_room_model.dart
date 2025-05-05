import 'room_model.dart';

class PrvRoomModel extends RoomModel {
  final bool isPrivate;
  final String createdBy;
  final List<String> memberships;

  PrvRoomModel({
    required String id,
    required String name,
    required String description,
    required DateTime createdAt,
    required this.isPrivate,
    required this.createdBy,
    required this.memberships,
  }) : super(
          id: id,
          name: name,
          description: description,
          createdAt: createdAt,
        );

  factory PrvRoomModel.fromJson(Map<String, dynamic> json) {
    return PrvRoomModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
      isPrivate: json['isPrivate'],
      createdBy: json['createdBy'],
      memberships: List<String>.from(json['memberships']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['isPrivate'] = isPrivate;
    json['createdBy'] = createdBy;
    json['memberships'] = memberships;
    return json;
  }
}