import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'student_info_event.dart';
part 'student_info_state.dart';

class StudentInfoBloc extends Bloc<StudentInfoEvent, StudentInfoState> {
  StudentInfoBloc() : super(StudentInfoInitial()) {
    on<LoadStudentInfo>((event, emit) async {
      emit(StudentInfoLoading());
      try {
        // Simulate network delay
        await Future.delayed(const Duration(seconds: 1));
        emit(StudentInfoLoaded());
      } catch (e) {
        emit(StudentInfoError(e.toString()));
      }
    });
  }
}
