import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'new_admission_event.dart';
part 'new_admission_state.dart';

class NewAdmissionBloc extends Bloc<NewAdmissionEvent, NewAdmissionState> {
  NewAdmissionBloc() : super(NewAdmissionInitial()) {
    on<LoadNewAdmission>((event, emit) async {
      emit(NewAdmissionLoading());
      try {
        // Simulate network delay
        await Future.delayed(const Duration(seconds: 1));
        emit(NewAdmissionLoaded());
      } catch (e) {
        emit(NewAdmissionError(e.toString()));
      }
    });
  }
}
