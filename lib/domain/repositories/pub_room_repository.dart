import 'package:steet/domain/entities/pub_room.dart';

abstract class PubRoomRepository {
  Future<List<PubRoom>> getPubRooms();
}
