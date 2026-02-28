part of 'time_table_bloc.dart';

abstract class TimeTableState extends Equatable {
  const TimeTableState();

  @override
  List<Object> get props => [];
}

class TimeTableInitial extends TimeTableState {}

class TimeTableLoading extends TimeTableState {}

class TimeTableLoaded extends TimeTableState {
  final String filePath;

  const TimeTableLoaded(this.filePath);

  @override
  List<Object> get props => [filePath];
}

class TimeTableError extends TimeTableState {
  final String message;

  const TimeTableError(this.message);

  @override
  List<Object> get props => [message];
}
