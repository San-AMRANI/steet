import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steet/data/data_sources/prv_rooms_data_source.dart';
import 'package:steet/data/repositories/prv_room_repository_imp.dart';
import 'package:steet/domain/repositories/prv_room_repository.dart';
import 'package:steet/domain/usecases/create_prv_room_usecase.dart';
import 'package:steet/domain/usecases/send_invitation_usecase.dart';
import 'package:steet/data/models/prv_room_model.dart';

// Dependencies for private rooms
final _prvDataSource = PrvRoomsDataSource();
final PrvRoomRepository _prvRepository = PrvRoomRepositoryImpl(_prvDataSource);
final _createPrvRoomUseCase = CreatePrvRoomUseCase(_prvRepository);
final _sendInvitationUseCase = SendInvitationUseCase(_prvRepository);

class CreatePrvRoomNotifier extends StateNotifier<AsyncValue<PrvRoomModel?>> {
  final CreatePrvRoomUseCase _createRoomUseCase;
  final SendInvitationUseCase _sendInvitationUseCase;

  CreatePrvRoomNotifier(this._createRoomUseCase, this._sendInvitationUseCase)
      : super(const AsyncValue.data(null));

  Future<void> createRoomAndSendInvitations({
    required String name,
    required String description,
    required bool isVisible,
    required String createdBy,
    required String imagePath,
    required List<String> invitedMembers,
  }) async {
    state = const AsyncValue.loading();
    try {
      // First create the room
      final room = await _createRoomUseCase.execute(
        name: name,
        description: description,
        isVisible: isVisible,
        createdBy: createdBy,
        imagePath: imagePath,
      );

      // Then send invitations to all members
      for (final memberId in invitedMembers) {
        await _sendInvitationUseCase.execute(
          roomId: room.id,
          invitedStudentId: memberId,
          inviterId: createdBy,
        );
      }

      state = AsyncValue.data(room);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

// Provider
final createPrvRoomProvider =
    StateNotifierProvider<CreatePrvRoomNotifier, AsyncValue<PrvRoomModel?>>(
  (ref) => CreatePrvRoomNotifier(
    _createPrvRoomUseCase,
    _sendInvitationUseCase,
  ),
);

// Parameters class for creating private rooms
class CreatePrvRoomParams {
  final String name;
  final String description;
  final bool isVisible;
  final String createdBy;
  final List<String> memberships;
  final String imagePath;

  CreatePrvRoomParams({
    required this.name,
    required this.description,
    required this.isVisible,
    required this.createdBy,
    required this.memberships,
    required this.imagePath,
  });
}

// // Provider for user's rooms (both private and public)
// final userRoomsProvider =
//     StateNotifierProvider<UserRoomsNotifier, AsyncValue<List<Room>>>((ref) {
//   return UserRoomsNotifier(_prvRepository, _pubRepository);
// });

// class UserRoomsNotifier extends StateNotifier<AsyncValue<List<Room>>> {
//   final PrvRoomRepositoryImpl _prvRepository;
//   final PubRoomRepositoryImpl _pubRepository;

//   UserRoomsNotifier(this._prvRepository, this._pubRepository)
//       : super(const AsyncValue.data([]));

//   Future<void> loadUserRooms() async {
//     try {
//       state = const AsyncValue.loading();
      
//       // Load both private and public rooms
//       final prvRooms = await _prvRepository.getUserRooms();
//       final pubRooms = await _pubRepository.getUserRooms();
      
//       // Combine both lists
//       final allRooms = [...prvRooms, ...pubRooms];
      
//       state = AsyncValue.data(allRooms);
//     } catch (e, stack) {
//       state = AsyncValue.error(e, stack);
//     }
//   }
// }
