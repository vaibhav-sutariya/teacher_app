part of 'transport_attendance_bloc.dart';

abstract class TransportAttendanceEvent extends Equatable {
  const TransportAttendanceEvent();

  @override
  List<Object> get props => [];
}

class LoadTransportAttendance extends TransportAttendanceEvent {}
