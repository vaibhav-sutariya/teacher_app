part of 'homework_bloc.dart';

abstract class HomeworkState extends Equatable {
  const HomeworkState();

  @override
  List<Object?> get props => [];
}

class HomeworkInitial extends HomeworkState {}

class HomeworkLoading extends HomeworkState {}

class HomeworkLoadedState extends HomeworkState {
  final List<HomeworkEntity> homeworkList;
  final DateTime selectedDate;

  const HomeworkLoadedState({
    required this.homeworkList,
    required this.selectedDate,
  });

  HomeworkLoadedState copyWith({
    List<HomeworkEntity>? homeworkList,
    DateTime? selectedDate,
  }) {
    return HomeworkLoadedState(
      homeworkList: homeworkList ?? this.homeworkList,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }

  @override
  List<Object?> get props => [homeworkList, selectedDate];
}

class HomeworkError extends HomeworkState {
  final String message;

  const HomeworkError(this.message);

  @override
  List<Object?> get props => [message];
}
