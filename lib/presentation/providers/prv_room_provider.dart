import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steet/data/data_sources/prv_rooms_data_source.dart';
import 'package:steet/data/repositories/prv_room_repository_impl.dart';
import 'package:steet/domain/entities/prv_room.dart';

// Single data source instance
final _dataSource = PrvRoomsDataSource();

// Single repository instance
final _repository = PrvRoomRepositoryImpl(dataSource: _dataSource);

// Simple FutureProvider for private rooms
final prvRoomsProvider = FutureProvider.autoDispose<List<PrvRoom>>((ref) async {
  return _repository.getPrvRooms();
});
