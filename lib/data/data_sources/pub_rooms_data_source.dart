import 'package:steet/core/constants/api_endpoints.dart';
import 'package:steet/core/utils/dio_service.dart';
import 'package:steet/data/models/pub_room_model.dart';

class PubRoomsDataSource {
  final DioService _dioService = DioService();

  Future<List<PubRoomModel>> getPubRooms() async {
    final dynamic response = await _dioService.get(ApiEndpoints.rooms);
    final List<dynamic> data = response is Map<String, dynamic>
        ? response['data'] as List<dynamic>
        : response as List<dynamic>;

    return data.map((room) => PubRoomModel.fromJson(room)).toList();
  }

  Future<PubRoomModel> createPubRoom({
    required String name,
    required String description,
    required String createdBy,
    required List<String> participation,
    required String imagePath,
  }) async {
    // 1. Upload image
    final imageUrl = await _dioService.uploadFile(
      endpoint: ApiEndpoints
          .createPublicRoom, // Adjust if you have a dedicated upload endpoint
      filePath: imagePath,
      fileField: 'image',
    );
    // 2. Create room with imageUrl
    final response = await _dioService.post(
      ApiEndpoints.createPublicRoom,
      data: {
        'name': name,
        'description': description,
        'createdBy': createdBy,
        'participation': participation,
        'imageUrl': imageUrl,
      },
    );
    return PubRoomModel.fromJson(response);
  }
}
