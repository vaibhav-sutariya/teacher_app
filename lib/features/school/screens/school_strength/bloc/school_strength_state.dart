part of 'school_strength_bloc.dart';

abstract class SchoolStrengthState extends Equatable {
  const SchoolStrengthState();

  @override
  List<Object?> get props => [];
}

class SchoolStrengthInitial extends SchoolStrengthState {}

class SchoolStrengthLoading extends SchoolStrengthState {}

class SchoolStrengthLoaded extends SchoolStrengthState {
  final SchoolStrengthModel strength;
  const SchoolStrengthLoaded({required this.strength});

  @override
  List<Object?> get props => [strength];
}

class SchoolStrengthError extends SchoolStrengthState {
  final String message;
  const SchoolStrengthError({required this.message});

  @override
  List<Object?> get props => [message];
}
