import 'package:steet/domain/entities/participation.dart';
import 'package:steet/domain/entities/prv_room.dart';
import 'package:steet/domain/entities/pub_room.dart';

class MockRoomsDataSource {
  // Mock data for public rooms
  final List<PubRoom> _mockPubRooms = [
    PubRoom(
      id: '1',
      name: 'Flutter Discussion',
      description: 'A place to discuss Flutter development',
      imageUrl: 'https://picsum.photos/200/300?random=1',
      createdAt: DateTime(2024, 1, 1),
      participation: [
        Participation(
          id: 'p1',
          idStudent: 'current_user_id',
          joinedAt: DateTime(2024, 1, 1),
        ),
        Participation(
          id: 'p2',
          idStudent: '2',
          joinedAt: DateTime(2024, 1, 2),
        ),
      ],
    ),
    PubRoom(
      id: '2',
      name: 'Dart Programming',
      description: 'Learn and share Dart programming knowledge',
      imageUrl: 'https://picsum.photos/200/300?random=2',
      createdAt: DateTime(2024, 1, 2),
      participation: [
        Participation(
          id: 'p3',
          idStudent: '3',
          joinedAt: DateTime(2024, 1, 2),
        ),
      ],
    ),
  ];

  // Mock data for private rooms
  final List<PrvRoom> _mockPrvRooms = [
    PrvRoom(
      id: '3',
      name: 'Project Team A',
      description: 'Private room for Project Team A',
      imageUrl: 'https://picsum.photos/200/300?random=3',
      createdAt: DateTime(2024, 1, 3),
      isVisible: true,
      createdBy: 'current_user_id',
      memberships: ['current_user_id', '2', '3'],
    ),
    PrvRoom(
      id: '4',
      name: 'Study Group',
      description: 'Private study group for Mobile Development',
      imageUrl: 'https://picsum.photos/200/300?random=4',
      createdAt: DateTime(2024, 1, 4),
      isVisible: false,
      createdBy: '2',
      memberships: ['current_user_id', '2'],
    ),
  ];

  // Get all public rooms
  Future<List<PubRoom>> getPubRooms() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockPubRooms;
  }

  // Get all private rooms
  Future<List<PrvRoom>> getPrvRooms() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockPrvRooms;
  }

  // Get private rooms where the user is a member
  Future<List<PrvRoom>> getUserPrvRooms(String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockPrvRooms
        .where((room) => room.memberships.contains(userId))
        .toList();
  }

  // Get private rooms created by the user
  Future<List<PrvRoom>> getUserCreatedPrvRooms(String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockPrvRooms.where((room) => room.createdBy == userId).toList();
  }

  // Get public rooms where the user is participating
  Future<List<PubRoom>> getUserPubRooms(String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockPubRooms
        .where((room) =>
            room.participation.any((p) => p.idStudent == userId && p.leftAt == null))
        .toList();
  }
} 