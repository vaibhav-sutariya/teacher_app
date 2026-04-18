import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/assignment_model.dart';
import '../../../repository/assignment_repository.dart';

part 'assignment_event.dart';
part 'assignment_state.dart';

class AssignmentBloc extends Bloc<AssignmentEvent, AssignmentState> {
  final AssignmentRepository repository;

  AssignmentBloc({required this.repository}) : super(AssignmentLoading()) {
    on<FetchAssignments>(_onFetchAssignments);
  }

  Future<void> _onFetchAssignments(
    FetchAssignments event,
    Emitter<AssignmentState> emit,
  ) async {
    emit(AssignmentLoading());
    final result = await repository.getAssignments();
    result.fold(
      (failure) => emit(AssignmentError(failure.message)),
      (assignments) => emit(AssignmentLoadedState(assignments)),
    );
  }
}
