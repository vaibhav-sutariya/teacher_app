import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'birthday_event.dart';
part 'birthday_state.dart';

class BirthdayBloc extends Bloc<BirthdayEvent, BirthdayState> {
  BirthdayBloc() : super(BirthdayInitial()) {
    on<LoadBirthday>((event, emit) async {
      emit(BirthdayLoading());
      try {
        // Simulate network delay
        await Future.delayed(const Duration(seconds: 1));
        emit(BirthdayLoaded());
      } catch (e) {
        emit(BirthdayError(e.toString()));
      }
    });
  }
}
