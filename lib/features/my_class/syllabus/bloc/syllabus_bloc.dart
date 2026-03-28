import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/syllabus_model.dart';
import '../repositories/syllabus_repository.dart';

part 'syllabus_event.dart';
part 'syllabus_state.dart';

class SyllabusBloc extends Bloc<SyllabusEvent, SyllabusState> {
  final SyllabusRepository repository;

  SyllabusBloc({required this.repository}) : super(SyllabusLoading()) {
    on<SyllabusLoaded>(_onSyllabusLoaded);
  }

  Future<void> _onSyllabusLoaded(
    SyllabusLoaded event,
    Emitter<SyllabusState> emit,
  ) async {
    emit(SyllabusLoading());
    final result = await repository.getSyllabus();
    result.fold(
      (failure) => emit(SyllabusError(failure.message)),
      (syllabusList) => emit(SyllabusLoadedState(syllabusList)),
    );
  }
}
