import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steet/data/data_sources/pub_rooms_data_source.dart';
import 'package:steet/data/repositories/pub_room_repository_imp.dart';
import 'package:steet/domain/entities/pub_room.dart';

// Single data source instance
final _dataSource = PubRoomsDataSource();

// Single repository instance
final _repository = PubRoomRepositoryImpl(_dataSource);

// Simple FutureProvider for public rooms
final pubRoomsProvider = FutureProvider.autoDispose<List<PubRoom>>((ref) async {
  return _repository.getPubRooms();
});
