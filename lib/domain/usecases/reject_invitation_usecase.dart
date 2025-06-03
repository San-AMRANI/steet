import 'package:steet/domain/repositories/invitation_repository.dart';
import 'package:steet/domain/entities/invitation.dart';

class RejectInvitationUseCase {
  final InvitationRepository _repository;

  RejectInvitationUseCase(this._repository);

  Future<bool> call(Invitation invitation) async {
    return await _repository.rejectInvitation(invitation);
  }
} 