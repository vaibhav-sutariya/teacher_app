part of 'admission_details_bloc.dart';

abstract class AdmissionDetailsEvent extends Equatable {
  const AdmissionDetailsEvent();

  @override
  List<Object?> get props => [];
}

class LoadDateAdmissions extends AdmissionDetailsEvent {
  final DateTime date;
  const LoadDateAdmissions(this.date);

  @override
  List<Object?> get props => [date];
}
