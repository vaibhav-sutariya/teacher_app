import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_concern_event.dart';
import 'add_concern_state.dart';

class AddConcernBloc extends Bloc<AddConcernEvent, AddConcernState> {
  AddConcernBloc() : super(const AddConcernState()) {
    on<SubmitConcern>(_onSubmitConcern);
    on<FileSelected>(_onFileSelected);
  }

  Future<void> _onSubmitConcern(
    SubmitConcern event,
    Emitter<AddConcernState> emit,
  ) async {
    emit(state.copyWith(status: AddConcernStatus.loading));

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      emit(
        state.copyWith(
          status: AddConcernStatus.success,
          message: 'Concern submitted successfully!',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: AddConcernStatus.failure, message: e.toString()),
      );
    }
  }

  void _onFileSelected(FileSelected event, Emitter<AddConcernState> emit) {
    emit(state.copyWith(attachmentPath: event.path));
  }
}
