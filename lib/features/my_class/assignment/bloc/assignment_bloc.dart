import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/assignment_model.dart';

part 'assignment_event.dart';
part 'assignment_state.dart';

class AssignmentBloc extends Bloc<AssignmentEvent, AssignmentState> {
  AssignmentBloc() : super(AssignmentLoading()) {
    on<AssignmentLoaded>(_onAssignmentLoaded);
  }

  Future<void> _onAssignmentLoaded(
    AssignmentLoaded event,
    Emitter<AssignmentState> emit,
  ) async {
    emit(AssignmentLoading());

    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Load mock data
      final assignmentList = AssignmentModel.getMockData();

      emit(AssignmentLoadedState(assignmentList));
    } catch (e) {
      emit(AssignmentError('Failed to load assignments: ${e.toString()}'));
    }
  }
}
