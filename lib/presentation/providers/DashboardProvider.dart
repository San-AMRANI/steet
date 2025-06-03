import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steet/data/data_sources/student_data_source.dart';
import 'package:steet/data/data_sources/prv_rooms_data_source.dart';
import 'package:steet/data/data_sources/pub_rooms_data_source.dart';
import 'package:steet/data/repositories/prv_room_repository_imp.dart';
import 'package:steet/data/repositories/prv_room_repository_impl.dart';
import 'package:steet/data/repositories/pub_room_repository_imp.dart';
import 'package:steet/data/repositories/student_repository_imp.dart';
import 'package:steet/domain/entities/prv_room.dart';
import 'package:steet/domain/entities/pub_room.dart';
import 'package:steet/domain/entities/student.dart';

// Dashboard state class
class DashboardState {
  final List<PubRoom> pubRooms;
  final List<PrvRoom> prvRooms;
  final List<Student> students;
  final List<int> studentCount;
  final bool isLoading;
  final String? error;

  const DashboardState({
    this.pubRooms = const [],
    this.prvRooms = const [],
    this.students = const [],
    this.studentCount = const [],
    this.isLoading = false,
    this.error,
  });

  int get totalPublicRooms => pubRooms.length;
  int get totalPrivateRooms => prvRooms.length;
  int get totalStudents => students.length;

  DashboardState copyWith({
    List<PubRoom>? pubRooms,
    List<PrvRoom>? prvRooms,
    List<Student>? students,
    List<int>? studentCount,
    bool? isLoading,
    String? error,
  }) {
    return DashboardState(
      pubRooms: pubRooms ?? this.pubRooms,
      prvRooms: prvRooms ?? this.prvRooms,
      students: students ?? this.students,
      studentCount: studentCount ?? this.studentCount,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

// Dashboard notifier
class DashboardNotifier extends Notifier<DashboardState> {
  late final StudentRepositoryImp _studentRepository;
  late final PrvRoomRepositoryImpl _prvRoomRepository;
  late final PubRoomRepositoryImpl _pubRoomRepository;

  @override
  DashboardState build() {
    _studentRepository = StudentRepositoryImp(dataSource: StudentDataSource());
    _pubRoomRepository =
        PubRoomRepositoryImpl(PubRoomsDataSource());
    _prvRoomRepository =
        PrvRoomRepositoryImpl( PrvRoomsDataSource());
    return const DashboardState();
  }

  // Fetch allprv rooms
  Future<void> fetchPrvRooms() async {
    state = state.copyWith(isLoading: true, error: null);
    try {       
      final rooms = await _prvRoomRepository.getPrvRooms();
      print(rooms);
      state = state.copyWith(prvRooms: rooms, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  // Fetch all pub rooms
  Future<void> fetchPubRooms() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final rooms = await _pubRoomRepository.getPubRooms();
      state = state.copyWith(pubRooms: rooms, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  // Fetch all students
  Future<void> fetchStudents() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final students = await _studentRepository.getStudents();
      state = state.copyWith(students: students, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<List<int>> getStudentCount() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final count = await _studentRepository.GetStudentCount();
      state = state.copyWith(isLoading: false);
      return count;
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
      return [0]; // Return 0 on error
    }
  }
}

// Provider definition
final dashboardProvider =
    NotifierProvider<DashboardNotifier, DashboardState>(() {
  return DashboardNotifier();
});

final pubRoomsProvider = FutureProvider<List<PubRoom>>((ref) async {
  final notifier = ref.watch(dashboardProvider.notifier);
  await notifier.fetchPubRooms();
  return ref.watch(dashboardProvider).pubRooms;
});
final prvRoomsProvider = FutureProvider<List<PrvRoom>>((ref) async {
  final notifier = ref.watch(dashboardProvider.notifier);
  await notifier.fetchPrvRooms();
  return ref.watch(dashboardProvider).prvRooms;
});
final studentsProvider = FutureProvider<List<Student>>((ref) async {
  final notifier = ref.watch(dashboardProvider.notifier);
  await notifier.fetchStudents();
  return ref.watch(dashboardProvider).students;
});
