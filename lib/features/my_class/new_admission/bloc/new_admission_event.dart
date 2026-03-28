part of 'new_admission_bloc.dart';

abstract class NewAdmissionEvent extends Equatable {
  const NewAdmissionEvent();

  @override
  List<Object?> get props => [];
}

class LoadMonthAdmissions extends NewAdmissionEvent {
  final DateTime month;
  const LoadMonthAdmissions(this.month);

  @override
  List<Object?> get props => [month];
}

class ChangeAdmissionMonth extends NewAdmissionEvent {
  final DateTime month;
  const ChangeAdmissionMonth(this.month);

  @override
  List<Object?> get props => [month];
}
