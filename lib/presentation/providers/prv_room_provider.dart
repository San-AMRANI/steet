import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steet/data/data_sources/prv_rooms_data_source.dart';
import 'package:steet/data/data_sources/pub_rooms_data_source.dart';
import 'package:steet/data/models/prv_room_model.dart';
import 'package:steet/data/repositories/prv_room_repository_imp.dart';
import 'package:steet/data/repositories/pub_room_repository_imp.dart';
import 'package:steet/domain/usecases/create_prv_room_usecase.dart';
import 'package:steet/domain/entities/room.dart';
import 'package:steet/domain/entities/prv_room.dart';
import 'package:steet/domain/entities/pub_room.dart';

// Dependencies for private rooms
final _prvDataSource = PrvRoomsDataSource();
final _prvRepository = PrvRoomRepositoryImpl(_prvDataSource);
final _createPrvRoomUseCase = CreatePrvRoomUseCase(_prvRepository);

// Dependencies for public rooms
final _pubDataSource = PubRoomsDataSource();
final _pubRepository = PubRoomRepositoryImpl(_pubDataSource);

// State notifier for private room creation
class CreatePrvRoomNotifier extends StateNotifier<AsyncValue<PrvRoomModel?>> {
  final CreatePrvRoomUseCase _useCase;

  CreatePrvRoomNotifier(this._useCase) : super(const AsyncValue.data(null));

  Future<void> createRoom({
    required String name,
    required String description,
    required bool isVisible,
    required String createdBy,
    required List<String> memberships,
    required String imagePath,
  }) async {
    state = const AsyncValue.loading();
    try {
      final room = await _useCase.execute(
        name: name,
        description: description,
        isVisible: isVisible,
        createdBy: createdBy,
        memberships: memberships,
        imagePath: imagePath,
      );
      state = AsyncValue.data(room);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

// Provider for private room creation
final createPrvRoomProvider =
    StateNotifierProvider<CreatePrvRoomNotifier, AsyncValue<PrvRoomModel?>>(
        (ref) {
  return CreatePrvRoomNotifier(_createPrvRoomUseCase);
});

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
