import 'package:equatable/equatable.dart';

import '../models/add_leave_request_model.dart';
import '../models/leave_type_model.dart';

abstract class AddLeaveEvent extends Equatable {
  const AddLeaveEvent();

  @override
  List<Object?> get props => [];
}

class SubmitLeaveRequest extends AddLeaveEvent {
  final AddLeaveRequestModel request;

  const SubmitLeaveRequest(this.request);

  @override
  List<Object?> get props => [request];
}

class LeaveTypeChanged extends AddLeaveEvent {
  final LeaveType? leaveType;

  const LeaveTypeChanged(this.leaveType);

  @override
  List<Object?> get props => [leaveType];
}

class DateRangeChanged extends AddLeaveEvent {
  final DateTime? fromDate;
  final DateTime? toDate;

  const DateRangeChanged({this.fromDate, this.toDate});

  @override
  List<Object?> get props => [fromDate, toDate];
}
