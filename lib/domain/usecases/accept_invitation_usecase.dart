import 'package:steet/domain/repositories/invitation_repository.dart';
import 'package:steet/domain/entities/invitation.dart';

class AcceptInvitationUseCase {
  final InvitationRepository _repository;

  AcceptInvitationUseCase(this._repository);

  Future<bool> call(Invitation invitation) async {
    return await _repository.acceptInvitation(invitation);
  }
} 