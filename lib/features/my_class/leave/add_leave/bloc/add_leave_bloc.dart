import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/add_leave_repository.dart';
import 'add_leave_event.dart';
import 'add_leave_state.dart';

class AddLeaveBloc extends Bloc<AddLeaveEvent, AddLeaveState> {
  final AddLeaveRepository _repository;

  AddLeaveBloc({required AddLeaveRepository repository})
    : _repository = repository,
      super(AddLeaveInitial()) {
    on<SubmitLeaveRequest>(_onSubmitLeaveRequest);
    // Add handlers for other events if needed for real-time validation
  }

  Future<void> _onSubmitLeaveRequest(
    SubmitLeaveRequest event,
    Emitter<AddLeaveState> emit,
  ) async {
    emit(AddLeaveLoading());

    // Calculate days for success message
    final days =
        event.request.toDate.difference(event.request.fromDate).inDays + 1;

    final result = await _repository.applyLeave(event.request);

    result.fold(
      (failure) => emit(AddLeaveError(failure.message)),
      (_) => emit(
        AddLeaveSuccess(
          message: 'Leave application submitted for $days day(s)',
          days: days,
        ),
      ),
    );
  }
}
