import 'package:steet/data/data_sources/prv_rooms_data_source.dart';
import 'package:steet/domain/entities/prv_room.dart';
import 'package:steet/domain/repositories/prv_room_repository.dart';

class PrvRoomRepositoryImpl implements PrvRoomRepository {
  final PrvRoomsDataSource dataSource;

  PrvRoomRepositoryImpl({required this.dataSource});



}
