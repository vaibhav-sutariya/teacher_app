part of 'exam_time_table_bloc.dart';

abstract class ExamTimeTableState extends Equatable {
  const ExamTimeTableState();

  @override
  List<Object> get props => [];
}

class ExamTimeTableInitial extends ExamTimeTableState {}

class ExamTimeTableLoading extends ExamTimeTableState {}

class ExamTimeTableLoaded extends ExamTimeTableState {
  final List<ExamTimeTableModel> examTimeTables;

  const ExamTimeTableLoaded(this.examTimeTables);

  @override
  List<Object> get props => [examTimeTables];
}

class ExamTimeTableError extends ExamTimeTableState {
  final String message;

  const ExamTimeTableError(this.message);

  @override
  List<Object> get props => [message];
}
