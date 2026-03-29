part of 'school_strength_bloc.dart';

abstract class SchoolStrengthEvent extends Equatable {
  const SchoolStrengthEvent();

  @override
  List<Object?> get props => [];
}

class LoadSchoolStrength extends SchoolStrengthEvent {}
