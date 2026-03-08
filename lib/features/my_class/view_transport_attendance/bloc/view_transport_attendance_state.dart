part of 'view_transport_attendance_bloc.dart';

abstract class ViewTransportAttendanceState extends Equatable {
  const ViewTransportAttendanceState();

  @override
  List<Object> get props => [];
}

class ViewTransportAttendanceInitial extends ViewTransportAttendanceState {}

class ViewTransportAttendanceLoading extends ViewTransportAttendanceState {}

class ViewTransportAttendanceLoaded extends ViewTransportAttendanceState {}

class ViewTransportAttendanceError extends ViewTransportAttendanceState {
  final String message;
  const ViewTransportAttendanceError(this.message);
  @override
  List<Object> get props => [message];
}
