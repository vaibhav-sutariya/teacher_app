import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../models/student_notice_model.dart';

import '../../../repositories/student_notice_repository.dart';

part 'student_notice_event.dart';
part 'student_notice_state.dart';

class StudentNoticeBloc extends Bloc<StudentNoticeEvent, StudentNoticeState> {
  final StudentNoticeRepository _repository;

  StudentNoticeBloc({StudentNoticeRepository? repository})
    : _repository = repository ?? StudentNoticeRepository(),
      super(StudentNoticeInitial()) {
    on<LoadStudentNotice>((event, emit) async {
      emit(StudentNoticeLoading());
      try {
        final notices = await _repository.getNotices();
        emit(StudentNoticeLoaded(notices));
      } catch (e) {
        emit(StudentNoticeError(e.toString()));
      }
    });
  }
}
