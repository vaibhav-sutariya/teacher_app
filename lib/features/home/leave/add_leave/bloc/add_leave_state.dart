import 'package:equatable/equatable.dart';

abstract class AddLeaveState extends Equatable {
  const AddLeaveState();

  @override
  List<Object?> get props => [];
}

class AddLeaveInitial extends AddLeaveState {}

class AddLeaveLoading extends AddLeaveState {}

class AddLeaveSuccess extends AddLeaveState {
  final String message;
  final int days;

  const AddLeaveSuccess({required this.message, required this.days});

  @override
  List<Object?> get props => [message, days];
}

class AddLeaveError extends AddLeaveState {
  final String message;

  const AddLeaveError(this.message);

  @override
  List<Object?> get props => [message];
}
