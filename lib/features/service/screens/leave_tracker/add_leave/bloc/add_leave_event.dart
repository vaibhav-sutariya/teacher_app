part of 'add_leave_bloc.dart';

abstract class AddLeaveEvent extends Equatable {
  const AddLeaveEvent();

  @override
  List<Object?> get props => [];
}

class LeaveTypeChanged extends AddLeaveEvent {
  final String type;
  const LeaveTypeChanged(this.type);

  @override
  List<Object?> get props => [type];
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
