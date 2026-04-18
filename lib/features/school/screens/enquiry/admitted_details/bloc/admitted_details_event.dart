part of 'admitted_details_bloc.dart';

abstract class AdmittedDetailsEvent extends Equatable {
  const AdmittedDetailsEvent();

  @override
  List<Object?> get props => [];
}

class LoadAdmittedDetails extends AdmittedDetailsEvent {
  final DateTime date;
  const LoadAdmittedDetails(this.date);

  @override
  List<Object?> get props => [date];
}
