part of 'transport_attendance_bloc.dart';

abstract class TransportAttendanceState extends Equatable {
  const TransportAttendanceState();

  @override
  List<Object> get props => [];
}

class TransportAttendanceInitial extends TransportAttendanceState {}

class TransportAttendanceLoading extends TransportAttendanceState {}

class TransportAttendanceLoaded extends TransportAttendanceState {}

class TransportAttendanceError extends TransportAttendanceState {
  final String message;
  const TransportAttendanceError(this.message);
  @override
  List<Object> get props => [message];
}
