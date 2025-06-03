import 'package:steet/domain/entities/prv_room.dart';

abstract class PrvRoomRepository {
  Future<List<PrvRoom>> getPrvRooms();
  Future<PrvRoom> getPrvRoom(String id);
  Future<void> createPrvRoom(PrvRoom room);
  Future<void> updatePrvRoom(PrvRoom room);
  Future<void> deletePrvRoom(String id);
}
