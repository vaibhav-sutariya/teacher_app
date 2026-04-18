part of 'add_leave_bloc.dart';

class AddLeaveState extends Equatable {
  final String? leaveType;
  final DateTime? fromDate;
  final DateTime? toDate;
  final String reason;
  final bool isImageSelected;
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const AddLeaveState({
    this.leaveType,
    this.fromDate,
    this.toDate,
    this.reason = '',
    this.isImageSelected = true,
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  AddLeaveState copyWith({
    String? leaveType,
    DateTime? fromDate,
    DateTime? toDate,
    String? reason,
    bool? isImageSelected,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return AddLeaveState(
      leaveType: leaveType ?? this.leaveType,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      reason: reason ?? this.reason,
      isImageSelected: isImageSelected ?? this.isImageSelected,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
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
        isSuccess,
        errorMessage,
      ];
}
