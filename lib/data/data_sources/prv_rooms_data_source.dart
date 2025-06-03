import 'package:steet/core/constants/api_endpoints.dart';
import 'package:steet/core/utils/dio_service.dart';
import 'package:steet/domain/entities/prv_room.dart';

class PrvRoomsDataSource {
  final DioService _dioService = DioService();
  final List<PrvRoom> _rooms = [];

  Future<List<PrvRoom>> getPrvRooms() async {
  try {
    final dynamic response = await _dioService.get(ApiEndpoints.allPrvRooms);
    print(response);

    if (response is List) {
      _rooms.clear(); // Clear existing rooms
      _rooms.addAll(
        response.map((roomJson) {
          final jsonMap = roomJson as Map<String, dynamic>;
          // Update isPrivate key to match API response
          jsonMap['isPrivate'] = jsonMap['private'] ?? false;
          return PrvRoom.fromJson(jsonMap);
        }).toList(),
      );
      return _rooms;
    }
  
    throw Exception('Invalid response format');
  } catch (e) {
    print('Error fetching private rooms: $e');
    throw Exception('Failed to fetch private rooms: $e');
  }
}



  Future<PrvRoom> getPrvRoom(String id) async {
    // TODO: Implement actual API call
    final room = _rooms.firstWhere((room) => room.id == id);
    return Future.value(room);
  }

  Future<void> createPrvRoom(PrvRoom room) async {
    // TODO: Implement actual API call
    _rooms.add(room);
  }

  Future<void> updatePrvRoom(PrvRoom room) async {
    // TODO: Implement actual API call
    final index = _rooms.indexWhere((r) => r.id == room.id);
    if (index != -1) {
      _rooms[index] = room;
    }
  }

  Future<void> deletePrvRoom(String id) async {
    // TODO: Implement actual API call
    _rooms.removeWhere((room) => room.id == id);
  }
}
