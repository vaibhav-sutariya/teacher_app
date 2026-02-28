import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/student_profile_model.dart';
import 'student_profile_event.dart';
import 'student_profile_state.dart';

class StudentProfileBloc
    extends Bloc<StudentProfileEvent, StudentProfileState> {
  StudentProfileBloc() : super(StudentProfileLoading()) {
    on<LoadStudentProfile>(_onLoadStudentProfile);
  }

  Future<void> _onLoadStudentProfile(
    LoadStudentProfile event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(StudentProfileLoading());
    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 1000));
      emit(StudentProfileLoaded(StudentProfileModel.mockData));
    } catch (e) {
      emit(StudentProfileError(e.toString()));
    }
  }
}
