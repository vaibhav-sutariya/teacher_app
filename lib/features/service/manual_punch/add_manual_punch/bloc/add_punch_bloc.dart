import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class AddPunchEvent extends Equatable {
  const AddPunchEvent();
  @override
  List<Object?> get props => [];
}

class SubmitPunch extends AddPunchEvent {
  final DateTime date;
  final String type;
  final String time;
  final String reason;

  const SubmitPunch({
    required this.date,
    required this.type,
    required this.time,
    required this.reason,
  });

  @override
  List<Object?> get props => [date, type, time, reason];
}

// State
abstract class AddPunchState extends Equatable {
  const AddPunchState();
  @override
  List<Object?> get props => [];
}

class AddPunchInitial extends AddPunchState {}

class AddPunchSubmitting extends AddPunchState {}

class AddPunchSuccess extends AddPunchState {}

class AddPunchError extends AddPunchState {
  final String message;
  const AddPunchError(this.message);
  @override
  List<Object?> get props => [message];
}

// Bloc
class AddPunchBloc extends Bloc<AddPunchEvent, AddPunchState> {
  AddPunchBloc() : super(AddPunchInitial()) {
    on<SubmitPunch>(_onSubmitPunch);
  }

  Future<void> _onSubmitPunch(
    SubmitPunch event,
    Emitter<AddPunchState> emit,
  ) async {
    emit(AddPunchSubmitting());
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      emit(AddPunchSuccess());
    } catch (e) {
      emit(AddPunchError(e.toString()));
    }
  }
}
