part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String selectedAcademicYear;
  final List<String> availableAcademicYears;

  const ProfileLoaded({
    this.selectedAcademicYear = '2025-2026',
    this.availableAcademicYears = const ['2023-2024', '2024-2025', '2025-2026'],
  });

  ProfileLoaded copyWith({
    String? selectedAcademicYear,
    List<String>? availableAcademicYears,
  }) {
    return ProfileLoaded(
      selectedAcademicYear: selectedAcademicYear ?? this.selectedAcademicYear,
      availableAcademicYears:
          availableAcademicYears ?? this.availableAcademicYears,
    );
  }

  @override
  List<Object?> get props => [selectedAcademicYear, availableAcademicYears];
}

class LogoutSuccess extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
