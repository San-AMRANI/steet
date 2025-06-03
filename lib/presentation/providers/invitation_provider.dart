import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steet/domain/entities/invitation.dart';
import 'package:steet/data/data_sources/invitation_data_source.dart';
import 'package:steet/data/repositories/invitation_repository_imp.dart';
import 'package:steet/domain/repositories/invitation_repository.dart';
import 'package:steet/domain/usecases/get_pending_invitations_usecase.dart';
import 'package:steet/domain/usecases/accept_invitation_usecase.dart';
import 'package:steet/domain/usecases/reject_invitation_usecase.dart';
import 'package:steet/presentation/providers/auth_provider.dart';

// Single instances
final _invitationDataSource = InvitationDataSource();
final InvitationRepository _invitationRepository = InvitationRepositoryImpl(_invitationDataSource);
final _getPendingInvitationsUseCase = GetPendingInvitationsUseCase(_invitationRepository);
final _acceptInvitationUseCase = AcceptInvitationUseCase(_invitationRepository);
final _rejectInvitationUseCase = RejectInvitationUseCase(_invitationRepository);

// Provider for pending invitations
final invitationProvider = FutureProvider.autoDispose<List<Invitation>>((ref) async {
  final authState = ref.watch(authProvider);
  if (authState.userId == null) {
    throw Exception('User not authenticated');
  }

  return await _getPendingInvitationsUseCase.call(authState.userId!);
});

// State class for invitation operations
class InvitationState {
  final Invitation? currentInvitation;
  final bool isLoading;
  final String? error;

  InvitationState({
    this.currentInvitation,
    this.isLoading = false,
    this.error,
  });

  InvitationState copyWith({
    Invitation? currentInvitation,
    bool? isLoading,
    String? error,
  }) {
    return InvitationState(
      currentInvitation: currentInvitation ?? this.currentInvitation,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// Notifier class for invitation operations
class InvitationNotifier extends StateNotifier<InvitationState> {
  final AcceptInvitationUseCase _acceptInvitationUseCase;
  final RejectInvitationUseCase _rejectInvitationUseCase;

  InvitationNotifier(this._acceptInvitationUseCase, this._rejectInvitationUseCase)
      : super(InvitationState());

  Future<bool> acceptInvitation(Invitation invitation) async {
    state = state.copyWith(isLoading: true, error: null, currentInvitation: invitation);
    try {
      final result = await _acceptInvitationUseCase.call(invitation);
      state = state.copyWith(isLoading: false);
      return result;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> rejectInvitation(Invitation invitation) async {
    state = state.copyWith(isLoading: true, error: null, currentInvitation: invitation);
    try {
      final result = await _rejectInvitationUseCase.call(invitation);
      state = state.copyWith(isLoading: false);
      return result;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }
}

// Provider for invitation operations
final invitationOperationsProvider =
    StateNotifierProvider<InvitationNotifier, InvitationState>((ref) {
  return InvitationNotifier(_acceptInvitationUseCase, _rejectInvitationUseCase);
});


