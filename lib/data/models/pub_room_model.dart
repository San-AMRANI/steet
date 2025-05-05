import 'room_model.dart';

class PubRoomModel extends RoomModel {
  final List<String> participation;

  PubRoomModel({
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

  factory PubRoomModel.fromJson(Map<String, dynamic> json) {
    return PubRoomModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
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