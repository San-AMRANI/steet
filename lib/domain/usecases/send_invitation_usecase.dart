import 'package:steet/domain/repositories/prv_room_repository.dart';

class SendInvitationUseCase {
  final PrvRoomRepository _repository;

  SendInvitationUseCase(this._repository);

  Future<bool> execute({
    required String roomId,
    required String invitedStudentId,
    required String inviterId,
  }) async {
    return await _repository.sendInvitation(
      roomId: roomId,
      invitedStudentId: invitedStudentId,
      inviterId: inviterId,
    );
  }
} 