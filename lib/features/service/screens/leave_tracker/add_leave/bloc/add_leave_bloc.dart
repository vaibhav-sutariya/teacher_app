import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_leave_event.dart';
part 'add_leave_state.dart';

class AddLeaveBloc extends Bloc<AddLeaveEvent, AddLeaveState> {
  AddLeaveBloc() : super(const AddLeaveState()) {
    on<LeaveTypeChanged>(_onLeaveTypeChanged);
    on<SaveDateRange>(_onSaveDateRange);
    on<ReasonChanged>(_onReasonChanged);
    on<FileTypeChanged>(_onFileTypeChanged);
    on<SubmitLeave>(_onSubmitLeave);
  }

  void _onLeaveTypeChanged(LeaveTypeChanged event, Emitter<AddLeaveState> emit) {
    emit(state.copyWith(leaveType: event.type));
  }

  void _onSaveDateRange(SaveDateRange event, Emitter<AddLeaveState> emit) {
    emit(state.copyWith(fromDate: event.fromDate, toDate: event.toDate));
  }

  void _onReasonChanged(ReasonChanged event, Emitter<AddLeaveState> emit) {
    emit(state.copyWith(reason: event.reason));
  }

  void _onFileTypeChanged(FileTypeChanged event, Emitter<AddLeaveState> emit) {
    emit(state.copyWith(isImageSelected: event.isImage));
  }

  Future<void> _onSubmitLeave(SubmitLeave event, Emitter<AddLeaveState> emit) async {
    if (state.leaveType == null || state.fromDate == null || state.toDate == null) {
      emit(state.copyWith(errorMessage: 'Please fill all fields'));
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
