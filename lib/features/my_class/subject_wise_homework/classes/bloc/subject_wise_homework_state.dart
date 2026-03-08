import 'package:equatable/equatable.dart';

abstract class SubjectWiseHomeworkState extends Equatable {
  const SubjectWiseHomeworkState();

  @override
  List<Object?> get props => [];
}

class SubjectWiseHomeworkInitial extends SubjectWiseHomeworkState {}

class SubjectWiseHomeworkLoading extends SubjectWiseHomeworkState {}

class SubjectWiseHomeworkLoadedState extends SubjectWiseHomeworkState {
  final List<String> classes;
  final DateTime selectedDate;

  const SubjectWiseHomeworkLoadedState({
    required this.classes,
    required this.selectedDate,
  });

  SubjectWiseHomeworkLoadedState copyWith({
    List<String>? classes,
    DateTime? selectedDate,
  }) {
    return SubjectWiseHomeworkLoadedState(
      classes: classes ?? this.classes,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }

  @override
  List<Object?> get props => [classes, selectedDate];
}

class SubjectWiseHomeworkError extends SubjectWiseHomeworkState {
  final String message;

  const SubjectWiseHomeworkError(this.message);

  @override
  List<Object?> get props => [message];
}
