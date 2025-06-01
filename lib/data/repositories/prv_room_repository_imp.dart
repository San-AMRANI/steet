import 'package:steet/data/data_sources/prv_rooms_data_source.dart';
import 'package:steet/data/models/prv_room_model.dart';

import 'package:steet/domain/repositories/prv_room_repository.dart';

class PrvRoomRepositoryImpl implements PrvRoomRepository {
  final PrvRoomsDataSource _dataSource;
  PrvRoomRepositoryImpl(this._dataSource);

  Future<PrvRoomModel> createPrvRoom({
    required String name,
    required String description,
    required bool isVisible,
    required String createdBy,
    required List<String> memberships,
    required String imagePath,
  }) async {
    return await _dataSource.createPrvRoom(
      name: name,
      description: description,
      isVisible: isVisible,
      createdBy: createdBy,
      memberships: memberships,
      imagePath: imagePath,
    );
  }
}
