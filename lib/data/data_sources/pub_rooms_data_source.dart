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
} 