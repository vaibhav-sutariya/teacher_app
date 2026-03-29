part of 'admitted_details_bloc.dart';

abstract class AdmittedDetailsState extends Equatable {
  const AdmittedDetailsState();

  @override
  List<Object?> get props => [];
}

class AdmittedDetailsInitial extends AdmittedDetailsState {}

class AdmittedDetailsLoading extends AdmittedDetailsState {}

class AdmittedDetailsLoaded extends AdmittedDetailsState {
  final List<EnquiryStudentModel> students;
  const AdmittedDetailsLoaded({required this.students});

  @override
  List<Object?> get props => [students];
}

class AdmittedDetailsError extends AdmittedDetailsState {
  final String message;
  const AdmittedDetailsError({required this.message});

  @override
  List<Object?> get props => [message];
}
