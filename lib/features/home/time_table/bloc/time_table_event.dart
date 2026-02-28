part of 'time_table_bloc.dart';

abstract class TimeTableEvent extends Equatable {
  const TimeTableEvent();

  @override
  List<Object> get props => [];
}

class LoadTimeTable extends TimeTableEvent {}

class RetryTimeTable extends TimeTableEvent {}
