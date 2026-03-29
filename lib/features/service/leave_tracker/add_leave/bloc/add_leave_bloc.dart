import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class AddLeaveEvent extends Equatable {
  const AddLeaveEvent();
  @override
  List<Object?> get props => [];
}

class LeaveTypeChanged extends AddLeaveEvent {
  final String leaveType;
  const LeaveTypeChanged(this.leaveType);
  @override
  List<Object?> get props => [leaveType];
}

class SaveDateRange extends AddLeaveEvent {
  final DateTime? fromDate;
  final DateTime? toDate;
  const SaveDateRange({this.fromDate, this.toDate});
  @override
  List<Object?> get props => [fromDate, toDate];
}

class ReasonChanged extends AddLeaveEvent {
  final String reason;
  const ReasonChanged(this.reason);
  @override
  List<Object?> get props => [reason];
}

class FileTypeChanged extends AddLeaveEvent {
  final bool isImage;
  const FileTypeChanged(this.isImage);
  @override
  List<Object?> get props => [isImage];
}

class SubmitLeave extends AddLeaveEvent {
  const SubmitLeave();
}

// State
class AddLeaveState extends Equatable {
  final String? leaveType;
  final DateTime? fromDate;
  final DateTime? toDate;
  final String reason;
  final bool isImageSelected;
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;

  const AddLeaveState({
    this.leaveType,
    this.fromDate,
    this.toDate,
    this.reason = '',
    this.isImageSelected = true,
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  AddLeaveState copyWith({
    String? leaveType,
    DateTime? fromDate,
    DateTime? toDate,
    String? reason,
    bool? isImageSelected,
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return AddLeaveState(
      leaveType: leaveType ?? this.leaveType,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      reason: reason ?? this.reason,
      isImageSelected: isImageSelected ?? this.isImageSelected,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [
        leaveType,
        fromDate,
        toDate,
        reason,
        isImageSelected,
        isLoading,
        errorMessage,
        isSuccess,
      ];
}

// Bloc
class AddLeaveBloc extends Bloc<AddLeaveEvent, AddLeaveState> {
  AddLeaveBloc() : super(const AddLeaveState()) {
    on<LeaveTypeChanged>((event, emit) {
      emit(state.copyWith(leaveType: event.leaveType));
    });

    on<SaveDateRange>((event, emit) {
      emit(state.copyWith(
        fromDate: event.fromDate,
        toDate: event.toDate,
      ));
    });

    on<ReasonChanged>((event, emit) {
      emit(state.copyWith(reason: event.reason));
    });

    on<FileTypeChanged>((event, emit) {
      emit(state.copyWith(isImageSelected: event.isImage));
    });

    on<SubmitLeave>((event, emit) async {
      if (state.leaveType == null ||
          state.fromDate == null ||
          state.toDate == null ||
          state.reason.isEmpty) {
        emit(state.copyWith(errorMessage: 'Please fill all required fields'));
        return;
      }

      emit(state.copyWith(isLoading: true, errorMessage: null));

      try {
        // Mocking API call
        await Future.delayed(const Duration(seconds: 2));
        emit(state.copyWith(isLoading: false, isSuccess: true));
      } catch (e) {
        emit(state.copyWith(isLoading: false, errorMessage: 'Failed to submit leave'));
      }
    });
  }
}
