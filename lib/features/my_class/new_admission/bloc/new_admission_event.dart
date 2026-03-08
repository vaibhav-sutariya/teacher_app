part of 'new_admission_bloc.dart';

abstract class NewAdmissionEvent extends Equatable {
  const NewAdmissionEvent();

  @override
  List<Object> get props => [];
}

class LoadNewAdmission extends NewAdmissionEvent {}
