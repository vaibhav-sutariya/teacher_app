import 'package:equatable/equatable.dart';

abstract class SubjectWiseHomeworkEvent extends Equatable {
  const SubjectWiseHomeworkEvent();

  @override
  List<Object?> get props => [];
}

class SubjectWiseHomeworkLoaded extends SubjectWiseHomeworkEvent {}

class SubjectWiseHomeworkDateChanged extends SubjectWiseHomeworkEvent {
  final DateTime date;

  const SubjectWiseHomeworkDateChanged(this.date);

  @override
  List<Object?> get props => [date];
}
