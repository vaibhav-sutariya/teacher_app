part of 'exam_time_table_bloc.dart';

abstract class ExamTimeTableState extends Equatable {
  const ExamTimeTableState();

  @override
  List<Object> get props => [];
}

class ExamTimeTableInitial extends ExamTimeTableState {}

class ExamTimeTableLoading extends ExamTimeTableState {}

class ExamTimeTableLoaded extends ExamTimeTableState {
  final String filePath;

  const ExamTimeTableLoaded(this.filePath);

  @override
  List<Object> get props => [filePath];
}

class ExamTimeTableError extends ExamTimeTableState {
  final String message;

  const ExamTimeTableError(this.message);

  @override
  List<Object> get props => [message];
}
