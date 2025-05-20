// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:steet/domain/entities/student.dart';
// import 'package:steet/domain/usecases/get_student_usecase.dart';

// part 'personal_information_state.dart';

// class PersonalInformationCubit extends Cubit<PersonalInformationState> {
//   final GetStudentByIdUseCase getStudentByIdUseCase;
//   final GetStudentByEmailUseCase getStudentByEmailUseCase;
//   final GetStudentByUserNameUseCase getStudentByUserNameUseCase;
  
//   PersonalInformationCubit({
//     required this.getStudentByIdUseCase,
//     required this.getStudentByEmailUseCase,
//     required this.getStudentByUserNameUseCase,
//   }) : super(PersonalInformationInitial());
  
//   Future<void> fetchStudentById(String id) async {
//     emit(PersonalInformationLoading());
//     try {
//       final student = await getStudentByIdUseCase.execute(id);
//       if (student != null) {
//         emit(PersonalInformationLoaded(student: student));
//       } else {
//         emit(PersonalInformationError('Student not found'));
//       }
//     } catch (e) {
//       emit(PersonalInformationError(e.toString()));
//     }
//   } 

//   Future<void> fetchStudentByEmail(String email) async {
//     emit(PersonalInformationLoading());
//     try{
//       final student = await getStudentByEmailUseCase.execute(email);
//       if (student != null) {
//         emit(PersonalInformationLoaded(student: student));
//       } else {
//         emit(PersonalInformationError('Student not found'));
//       }
//     }catch(e){
//       emit(PersonalInformationError(e.toString()));
//     }
//   }

//   Future<void> fetchStudentByUserName(String userName) async {
//     emit(PersonalInformationLoading());
//     try{
//       final student = await getStudentByUserNameUseCase.execute(userName);
//       if (student != null) {
//         emit(PersonalInformationLoaded(student: student));
//       } else {
//         emit(PersonalInformationError('Student not found'));
//       }
//     }catch(e){
//       emit(PersonalInformationError(e.toString()));
//     }
//   }
// }
