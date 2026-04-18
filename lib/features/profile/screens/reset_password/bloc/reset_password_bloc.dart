import 'package:flutter_bloc/flutter_bloc.dart';

import 'reset_password_event.dart';
import 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc() : super(const ResetPasswordState()) {
    on<CurrentPasswordChanged>(_onCurrentPasswordChanged);
    on<NewPasswordChanged>(_onNewPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<SubmitResetPassword>(_onSubmitResetPassword);
  }

  void _onCurrentPasswordChanged(
    CurrentPasswordChanged event,
    Emitter<ResetPasswordState> emit,
  ) {
    emit(
      state.copyWith(
        currentPassword: event.password,
        isValid: _checkIsValid(
          event.password,
          state.newPassword,
          state.confirmPassword,
        ),
        status: ResetPasswordStatus.initial, // Reset error text on typing
        errorMessage: null,
      ),
    );
  }

  void _onNewPasswordChanged(
    NewPasswordChanged event,
    Emitter<ResetPasswordState> emit,
  ) {
    emit(
      state.copyWith(
        newPassword: event.password,
        isValid: _checkIsValid(
          state.currentPassword,
          event.password,
          state.confirmPassword,
        ),
        status: ResetPasswordStatus.initial,
        errorMessage: null,
      ),
    );
  }

  void _onConfirmPasswordChanged(
    ConfirmPasswordChanged event,
    Emitter<ResetPasswordState> emit,
  ) {
    emit(
      state.copyWith(
        confirmPassword: event.password,
        isValid: _checkIsValid(
          state.currentPassword,
          state.newPassword,
          event.password,
        ),
        status: ResetPasswordStatus.initial,
        errorMessage: null,
      ),
    );
  }

  bool _checkIsValid(String current, String newPass, String confirm) {
    return current.isNotEmpty && newPass.isNotEmpty && confirm.isNotEmpty;
  }

  Future<void> _onSubmitResetPassword(
    SubmitResetPassword event,
    Emitter<ResetPasswordState> emit,
  ) async {
    if (!state.isValid) return;

    if (state.newPassword != state.confirmPassword) {
      emit(
        state.copyWith(
          status: ResetPasswordStatus.error,
          errorMessage: 'New password and confirm password do not match.',
        ),
      );
      return;
    }

    if (state.newPassword.length < 6) {
      emit(
        state.copyWith(
          status: ResetPasswordStatus.error,
          errorMessage: 'Password must be at least 6 characters long.',
        ),
      );
      return;
    }

    emit(state.copyWith(status: ResetPasswordStatus.submitting));

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      emit(state.copyWith(status: ResetPasswordStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: ResetPasswordStatus.error,
          errorMessage: 'Failed to reset password. Please try again.',
        ),
      );
    }
  }
}
