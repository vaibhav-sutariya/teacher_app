import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../models/student_leave_model.dart';

part 'student_leave_event.dart';
part 'student_leave_state.dart';

class StudentLeaveBloc extends Bloc<StudentLeaveEvent, StudentLeaveState> {
  StudentLeaveBloc() : super(StudentLeaveInitial()) {
    on<LoadStudentLeaves>(_onLoadStudentLeaves);
    on<ChangeStudentLeaveTab>(_onChangeStudentLeaveTab);
  }

  void _onLoadStudentLeaves(
      LoadStudentLeaves event, Emitter<StudentLeaveState> emit) {
    emit(StudentLeaveLoading());
    try {
      final leaves = StudentLeaveModel.getMockData();
      emit(StudentLeaveLoaded(allLeaves: leaves));
    } catch (e) {
      emit(StudentLeaveError(e.toString()));
    }
  }

  void _onChangeStudentLeaveTab(
      ChangeStudentLeaveTab event, Emitter<StudentLeaveState> emit) {
    if (state is StudentLeaveLoaded) {
      final currentState = state as StudentLeaveLoaded;
      emit(StudentLeaveLoaded(
        allLeaves: currentState.allLeaves,
        selectedTabIndex: event.index,
      ));
    }
  }
}
