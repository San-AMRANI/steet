import 'package:steet/domain/repositories/prv_room_repository.dart';
import 'package:steet/data/models/prv_room_model.dart';

class CreatePrvRoomUseCase {
  final PrvRoomRepository _repository;

  CreatePrvRoomUseCase(this._repository);

  Future<PrvRoomModel> execute({
    required String name,
    required String description,
    required bool isVisible,
    required String createdBy,
    required String imagePath,
  }) async {
    return await _repository.createPrvRoom(
      name: name,
      description: description,
      isVisible: isVisible,
      createdBy: createdBy,
      imagePath: imagePath,
    );
  }
}
