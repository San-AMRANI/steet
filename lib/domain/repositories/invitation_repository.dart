import 'package:steet/domain/entities/invitation.dart';

abstract class InvitationRepository {
  Future<List<Invitation>> getPendingInvitations(String studentId);
  Future<bool> acceptInvitation(Invitation invitation);
  Future<bool> rejectInvitation(Invitation invitation);
} 