
import 'package:steet/data/data_sources/pub_rooms_data_source.dart';
import 'package:steet/domain/entities/pub_room.dart';
import 'package:steet/domain/repositories/pub_room_repository.dart';

class PubRoomRepositoryImpl implements PubRoomRepository {
  final PubRoomsDataSource _dataSource;

  PubRoomRepositoryImpl(this._dataSource);  
  
  @override
  Future<List<PubRoom>> getPubRooms() async {
    try {
      final pubRoomModels = await _dataSource.getPubRooms();
      final pubRooms = pubRoomModels.map((model) => model.toEntity()).toList();
      return pubRooms;
    } catch (e) {
      rethrow;
    }
  }
}