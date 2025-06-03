import 'package:steet/data/data_sources/prv_rooms_data_source.dart';
import 'package:steet/domain/entities/prv_room.dart';
import 'package:steet/domain/repositories/prv_room_repository.dart';

class PrvRoomRepositoryImpl implements PrvRoomRepository {
  final PrvRoomsDataSource dataSource;

  PrvRoomRepositoryImpl({required this.dataSource});

  @override
  Future<List<PrvRoom>> getPrvRooms() {
    return dataSource.getPrvRooms();
  }

  @override
  Future<PrvRoom> getPrvRoom(String id) => dataSource.getPrvRoom(id);

  @override
  Future<void> createPrvRoom(PrvRoom room) => dataSource.createPrvRoom(room);

  @override
  Future<void> updatePrvRoom(PrvRoom room) => dataSource.updatePrvRoom(room);

  @override
  Future<void> deletePrvRoom(String id) => dataSource.deletePrvRoom(id);
}
