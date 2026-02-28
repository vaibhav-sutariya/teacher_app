import 'package:equatable/equatable.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

class CurrentPasswordChanged extends ResetPasswordEvent {
  final String password;

  const CurrentPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class NewPasswordChanged extends ResetPasswordEvent {
  final String password;

  const NewPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class ConfirmPasswordChanged extends ResetPasswordEvent {
  final String password;

  const ConfirmPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class SubmitResetPassword extends ResetPasswordEvent {}
