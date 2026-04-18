import 'package:equatable/equatable.dart';

abstract class SubjectWiseHomeworkSubjectEvent extends Equatable {
  const SubjectWiseHomeworkSubjectEvent();

  @override
  List<Object?> get props => [];
}

class LoadSubjectsEvent extends SubjectWiseHomeworkSubjectEvent {
  final String className;
  const LoadSubjectsEvent(this.className);

  @override
  List<Object?> get props => [className];
}
