import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_punch_event.dart';
part 'add_punch_state.dart';

class AddPunchBloc extends Bloc<AddPunchEvent, AddPunchState> {
  AddPunchBloc() : super(AddPunchInitial()) {
    on<SubmitPunch>(_onSubmitPunch);
  }

  Future<void> _onSubmitPunch(
      SubmitPunch event, Emitter<AddPunchState> emit) async {
    emit(AddPunchSubmitting());
    try {
      // Mock submit delay
      await Future.delayed(const Duration(seconds: 1));
      emit(AddPunchSuccess());
    } catch (e) {
      emit(AddPunchError(e.toString()));
    }
  }
}
