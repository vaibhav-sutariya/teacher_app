import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'student_notice_event.dart';
part 'student_notice_state.dart';

class StudentNoticeBloc extends Bloc<StudentNoticeEvent, StudentNoticeState> {
  StudentNoticeBloc() : super(StudentNoticeInitial()) {
    on<LoadStudentNotice>((event, emit) async {
      emit(StudentNoticeLoading());
      try {
        // Simulate network delay
        await Future.delayed(const Duration(seconds: 1));
        emit(StudentNoticeLoaded());
      } catch (e) {
        emit(StudentNoticeError(e.toString()));
      }
    });
  }
}
