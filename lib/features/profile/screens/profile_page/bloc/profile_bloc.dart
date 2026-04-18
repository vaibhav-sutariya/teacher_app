import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileLoaded()) {
    on<LogoutRequested>(_onLogoutRequested);
    on<SelectAcademicYear>(_onSelectAcademicYear);
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      // Background logout API call without UI blocking
      await Future.delayed(const Duration(milliseconds: 1000));
      // Optionally we could store logout status elsewhere,
      // but UI handles immediate navigation separately.
    } catch (e) {
      // Handle error gracefully if needed in background
      // emit(ProfileError(e.toString()));
    }
  }

  void _onSelectAcademicYear(
    SelectAcademicYear event,
    Emitter<ProfileState> emit,
  ) {
    if (state is ProfileLoaded) {
      final currentState = state as ProfileLoaded;
      emit(currentState.copyWith(selectedAcademicYear: event.year));
    }
  }
}
