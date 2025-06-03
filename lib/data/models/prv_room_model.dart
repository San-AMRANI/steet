import 'package:steet/domain/entities/prv_room.dart';
import 'room_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
    final String? rawImageUrl = json['imageUrl'] as String?;
    final String imageUrl = buildRoomPictureUrl(rawImageUrl) ?? '/rooms/room-image/default.jpg';

    return PrvRoomModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: imageUrl,
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

  PrvRoom toEntity() {
    return PrvRoom(
      id: id,
      name: name,
      description: description,
      imageUrl: imageUrl,
      createdAt: createdAt,
      isVisible: isVisible,
      createdBy: createdBy,
      memberships: memberships,
    );
  }

  static String? buildRoomPictureUrl(String? rawUrl) {
    if (rawUrl == null || rawUrl.isEmpty) return null;
    final baseUrl = dotenv.env['BASE_URL'] ?? '';
    return baseUrl + rawUrl;
  }
}
