import 'package:steet/domain/repositories/invitation_repository.dart';
import 'package:steet/domain/entities/invitation.dart';

class GetPendingInvitationsUseCase {
  final InvitationRepository _repository;

  GetPendingInvitationsUseCase(this._repository);

  Future<List<Invitation>> call(String studentId) async {
    return await _repository.getPendingInvitations(studentId);
  }
} 