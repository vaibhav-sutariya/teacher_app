part of 'add_punch_bloc.dart';

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
