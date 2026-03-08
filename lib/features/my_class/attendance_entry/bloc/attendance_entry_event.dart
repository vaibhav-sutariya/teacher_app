import 'package:equatable/equatable.dart';
import '../models/student_attendance_model.dart';

abstract class AttendanceEntryEvent extends Equatable {
  const AttendanceEntryEvent();

  @override
  List<Object?> get props => [];
}

class LoadAttendanceEntry extends AttendanceEntryEvent {
  final String className;
  final DateTime date;

  const LoadAttendanceEntry(this.className, this.date);

  @override
  List<Object?> get props => [className, date];
}

class ToggleSendSms extends AttendanceEntryEvent {
  final bool value;
  const ToggleSendSms(this.value);

  @override
  List<Object?> get props => [value];
}

class MarkStudentStatus extends AttendanceEntryEvent {
  final String studentId;
  final AttendanceStatusEnum status;
  const MarkStudentStatus(this.studentId, this.status);

  @override
  List<Object?> get props => [studentId, status];
}

class ChangeSpecialStatus extends AttendanceEntryEvent {
  final String studentId;
  final String specialStatus;
  const ChangeSpecialStatus(this.studentId, this.specialStatus);

  @override
  List<Object?> get props => [studentId, specialStatus];
}
