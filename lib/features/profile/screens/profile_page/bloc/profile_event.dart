part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LogoutRequested extends ProfileEvent {}

class SelectAcademicYear extends ProfileEvent {
  final String year;

  const SelectAcademicYear(this.year);

  @override
  List<Object?> get props => [year];
}
