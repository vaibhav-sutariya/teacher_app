import 'package:equatable/equatable.dart';

abstract class ViewTransportAttendanceEvent extends Equatable {
  const ViewTransportAttendanceEvent();

  @override
  List<Object> get props => [];
}

class LoadRoutesForDateEvent extends ViewTransportAttendanceEvent {}

class ChangeTabEvent extends ViewTransportAttendanceEvent {
  final int index;
  const ChangeTabEvent(this.index);

  @override
  List<Object> get props => [index];
}

class SelectDateEvent extends ViewTransportAttendanceEvent {
  final DateTime date;
  const SelectDateEvent(this.date);

  @override
  List<Object> get props => [date];
}
