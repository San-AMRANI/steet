import 'package:steet/data/data_sources/invitation_data_source.dart';
import 'package:steet/domain/repositories/invitation_repository.dart';
import 'package:steet/domain/entities/invitation.dart';
import 'package:steet/data/models/invitation_model.dart';

class InvitationRepositoryImpl implements InvitationRepository {
  final InvitationDataSource _dataSource;

  InvitationRepositoryImpl(this._dataSource);

  @override
  Future<List<Invitation>> getPendingInvitations(String studentId) async {
    final models = await _dataSource.getPendingInvitations(studentId);
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<bool> acceptInvitation(Invitation invitation) async {
    // Convert the domain entity back to a model
    final invitationModel = invitation as InvitationModel;
    return await _dataSource.acceptInvitation(invitationModel);
  }

  @override
  Future<bool> rejectInvitation(Invitation invitation) async {
    // Convert the domain entity back to a model
    final invitationModel = invitation as InvitationModel;
    return await _dataSource.rejectInvitation(invitationModel);
  }
} 