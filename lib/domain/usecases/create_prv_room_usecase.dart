import 'package:steet/data/models/prv_room_model.dart';
import 'package:steet/data/repositories/prv_room_repository_imp.dart';

class CreatePrvRoomUseCase {
  final PrvRoomRepositoryImpl _repository;

  CreatePrvRoomUseCase(this._repository);

  Future<PrvRoomModel> execute({
    required String name,
    required String description,
    required bool isVisible,
    required String createdBy,
    required List<String> memberships,
    required String imagePath,
  }) async {
    return await _repository.createPrvRoom(
      name: name,
      description: description,
      isVisible: isVisible,
      createdBy: createdBy,
      memberships: memberships,
      imagePath: imagePath,
    );
  }
}
