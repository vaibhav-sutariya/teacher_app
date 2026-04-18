part of 'time_table_bloc.dart';

abstract class TimeTableEvent extends Equatable {
  const TimeTableEvent();

  @override
  List<Object?> get props => [];
}

class LoadTimeTables extends TimeTableEvent {}

class AddTimeTable extends TimeTableEvent {
  final TimeTableModel timetable;

  const AddTimeTable(this.timetable);

  @override
  List<Object?> get props => [timetable];
}

class RetryTimeTable extends TimeTableEvent {}
