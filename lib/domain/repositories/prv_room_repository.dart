import 'package:steet/data/models/prv_room_model.dart';
import 'package:steet/domain/entities/prv_room.dart';

abstract class PrvRoomRepository {
  
  Future<PrvRoomModel> createPrvRoom({
    required String name,
    required String description,
    required bool isVisible,
    required String createdBy,
    required String imagePath,
  });

  Future<bool> sendInvitation({
    required String roomId,
    required String invitedStudentId,
    required String inviterId,
  });
  Future<List<PrvRoom>> getPrvRooms();
}
