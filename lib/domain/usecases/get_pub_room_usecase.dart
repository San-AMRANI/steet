
import 'package:steet/domain/entities/pub_room.dart';
import 'package:steet/domain/repositories/pub_room_repository.dart';

class GetPubRoomsUsecase {
  final PubRoomRepository _pubRoomRepository;

  GetPubRoomsUsecase(this._pubRoomRepository);

  Future<List<PubRoom>> execute() async {
    return await _pubRoomRepository.getPubRooms();
  }
}