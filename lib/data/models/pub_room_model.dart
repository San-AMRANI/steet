import 'package:steet/domain/entities/pub_room.dart';
import 'participation_model.dart';
import 'room_model.dart';

class PubRoomModel extends RoomModel {
  final List<ParticipationModel> participation;

  PubRoomModel({
    required super.id,
    required super.name,
    required super.description,
    required super.createdAt,
    required this.participation,
  });

  factory PubRoomModel.fromJson(Map<String, dynamic> json) {
    return PubRoomModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      participation: json['participation'] != null 
          ? (json['participation'] as List<dynamic>)
              .map((p) => ParticipationModel.fromJson(p))
              .toList()
          : [],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['participation'] = participation.map((p) => p.toJson()).toList();
    return json;
  }

  PubRoom toEntity() {
    return PubRoom(
      id: id,
      name: name,
      description: description,
      createdAt: createdAt,
      participation: participation.map((p) => p.toEntity()).toList(),
    );
  }
}