part of 'new_admission_bloc.dart';

abstract class NewAdmissionState extends Equatable {
  const NewAdmissionState();

  @override
  List<Object> get props => [];
}

class NewAdmissionInitial extends NewAdmissionState {}

class NewAdmissionLoading extends NewAdmissionState {}

class NewAdmissionLoaded extends NewAdmissionState {}

class NewAdmissionError extends NewAdmissionState {
  final String message;
  const NewAdmissionError(this.message);
  @override
  List<Object> get props => [message];
}
