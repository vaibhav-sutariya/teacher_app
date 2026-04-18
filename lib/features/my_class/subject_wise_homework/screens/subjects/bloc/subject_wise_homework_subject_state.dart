import 'package:equatable/equatable.dart';

abstract class SubjectWiseHomeworkSubjectState extends Equatable {
  const SubjectWiseHomeworkSubjectState();

  @override
  List<Object?> get props => [];
}

class SubjectWiseHomeworkSubjectInitial
    extends SubjectWiseHomeworkSubjectState {}

class SubjectWiseHomeworkSubjectLoading
    extends SubjectWiseHomeworkSubjectState {}

class SubjectWiseHomeworkSubjectLoaded extends SubjectWiseHomeworkSubjectState {
  final List<String> subjects;
  const SubjectWiseHomeworkSubjectLoaded(this.subjects);

  @override
  List<Object?> get props => [subjects];
}

class SubjectWiseHomeworkSubjectError extends SubjectWiseHomeworkSubjectState {
  final String message;
  const SubjectWiseHomeworkSubjectError(this.message);

  @override
  List<Object?> get props => [message];
}
