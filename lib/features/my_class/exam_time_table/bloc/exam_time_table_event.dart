part of 'exam_time_table_bloc.dart';

abstract class ExamTimeTableEvent extends Equatable {
  const ExamTimeTableEvent();

  @override
  List<Object> get props => [];
}

class LoadExamTimeTable extends ExamTimeTableEvent {}
