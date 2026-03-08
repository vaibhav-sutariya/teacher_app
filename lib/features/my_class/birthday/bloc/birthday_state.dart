part of 'birthday_bloc.dart';

abstract class BirthdayState extends Equatable {
  const BirthdayState();

  @override
  List<Object> get props => [];
}

class BirthdayInitial extends BirthdayState {}

class BirthdayLoading extends BirthdayState {}

class BirthdayLoaded extends BirthdayState {}

class BirthdayError extends BirthdayState {
  final String message;
  const BirthdayError(this.message);
  @override
  List<Object> get props => [message];
}
