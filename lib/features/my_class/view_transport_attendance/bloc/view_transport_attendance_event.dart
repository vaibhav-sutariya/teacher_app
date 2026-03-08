part of 'view_transport_attendance_bloc.dart';

abstract class ViewTransportAttendanceEvent extends Equatable {
  const ViewTransportAttendanceEvent();

  @override
  List<Object> get props => [];
}

class LoadViewTransportAttendance extends ViewTransportAttendanceEvent {}
