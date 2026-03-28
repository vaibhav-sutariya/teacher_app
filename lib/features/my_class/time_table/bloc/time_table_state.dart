part of 'time_table_bloc.dart';

abstract class TimeTableState extends Equatable {
  const TimeTableState();

  @override
  List<Object?> get props => [];
}

class TimeTableInitial extends TimeTableState {}

class TimeTableLoading extends TimeTableState {}

class TimeTableLoaded extends TimeTableState {
  final List<TimeTableModel> timetables;

  const TimeTableLoaded(this.timetables);

  @override
  List<Object?> get props => [timetables];
}

class TimeTableError extends TimeTableState {
  final String message;

  const TimeTableError(this.message);

  @override
  List<Object?> get props => [message];
}

class TimeTableAdding extends TimeTableState {}

class TimeTableAdded extends TimeTableState {}
