import 'package:steet/data/data_sources/pub_rooms_data_source.dart';
import 'package:steet/data/models/pub_room_model.dart';
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

  Future<PubRoomModel> createPubRoom({
    required String name,
    required String description,
    required String createdBy,
    required List<String> participation,
    required String imagePath,
  }) async {
    return await _dataSource.createPubRoom(
      name: name,
      description: description,
      createdBy: createdBy,
      participation: participation,
      imagePath: imagePath,
    );
  }
}
