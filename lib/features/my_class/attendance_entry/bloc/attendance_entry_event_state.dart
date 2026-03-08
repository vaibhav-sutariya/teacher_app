import 'package:equatable/equatable.dart';
import '../models/student_attendance_model.dart';

// --- EVENTS ---
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

// --- STATE ---
class AttendanceEntryState extends Equatable {
  final bool isLoading;
  final String className;
  final DateTime date;
  final bool sendSms;
  final List<StudentAttendanceModel> students;
  final String? errorMessage;

  const AttendanceEntryState({
    this.isLoading = false,
    required this.className,
    required this.date,
    this.sendSms = true,
    this.students = const [],
    this.errorMessage,
  });

  factory AttendanceEntryState.initial() {
    return AttendanceEntryState(className: '', date: DateTime.now());
  }

  AttendanceEntryState copyWith({
    bool? isLoading,
    String? className,
    DateTime? date,
    bool? sendSms,
    List<StudentAttendanceModel>? students,
    String? errorMessage,
    bool clearError = false,
  }) {
    return AttendanceEntryState(
      isLoading: isLoading ?? this.isLoading,
      className: className ?? this.className,
      date: date ?? this.date,
      sendSms: sendSms ?? this.sendSms,
      students: students ?? this.students,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    className,
    date,
    sendSms,
    students,
    errorMessage,
  ];
}
