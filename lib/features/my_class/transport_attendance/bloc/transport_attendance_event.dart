import 'package:equatable/equatable.dart';
import '../models/transport_student_model.dart';

abstract class TransportAttendanceEvent extends Equatable {
  const TransportAttendanceEvent();

  @override
  List<Object?> get props => [];
}

class SelectRouteEvent extends TransportAttendanceEvent {
  final String route;
  const SelectRouteEvent(this.route);

  @override
  List<Object?> get props => [route];
}

class SelectDateEvent extends TransportAttendanceEvent {
  final DateTime date;
  const SelectDateEvent(this.date);

  @override
  List<Object?> get props => [date];
}

class LoadStudentsEvent extends TransportAttendanceEvent {}

class SearchStudentsEvent extends TransportAttendanceEvent {
  final String query;
  const SearchStudentsEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class ToggleAttendanceStatusEvent extends TransportAttendanceEvent {
  final String studentId;
  final TransportAttendanceStatus status;

  const ToggleAttendanceStatusEvent(this.studentId, this.status);

  @override
  List<Object?> get props => [studentId, status];
}

class SubmitAttendanceEvent extends TransportAttendanceEvent {}
