import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';
import '../../models/class_info_model.dart';
import '../../models/student_model.dart';
import '../../repositories/student_info_repository.dart';

part 'student_info_event.dart';
part 'student_info_state.dart';

const _duration = Duration(milliseconds: 300);

EventTransformer<Event> restartableDebounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class StudentInfoBloc extends Bloc<StudentInfoEvent, StudentInfoState> {
  final StudentInfoRepository repository;

  StudentInfoBloc({required this.repository})
    : super(StudentInfoState.initial()) {
    on<ChangeTabEvent>(
      (event, emit) => emit(state.copyWith(tabIndex: event.index)),
    );

    on<LoadClassesEvent>(_onLoadClasses);

    on<SearchStudentsEvent>(
      _onSearchStudents,
      transformer: restartableDebounce(_duration),
    );
  }

  Future<void> _onLoadClasses(
    LoadClassesEvent event,
    Emitter<StudentInfoState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await repository.getClasses();
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (classes) => emit(state.copyWith(isLoading: false, classes: classes)),
    );
  }

  Future<void> _onSearchStudents(
    SearchStudentsEvent event,
    Emitter<StudentInfoState> emit,
  ) async {
    if (event.query == state.searchQuery && state.students.isNotEmpty) return;

    emit(
      state.copyWith(isLoading: true, searchQuery: event.query, error: null),
    );

    final result = await repository.searchStudents(event.query);
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (students) => emit(state.copyWith(isLoading: false, students: students)),
    );
  }
}
