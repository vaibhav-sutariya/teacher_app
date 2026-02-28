import 'package:equatable/equatable.dart';

enum ResetPasswordStatus { initial, submitting, success, error }

class ResetPasswordState extends Equatable {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;
  final ResetPasswordStatus status;
  final String? errorMessage;
  final bool isValid;

  const ResetPasswordState({
    this.currentPassword = '',
    this.newPassword = '',
    this.confirmPassword = '',
    this.status = ResetPasswordStatus.initial,
    this.errorMessage,
    this.isValid = false,
  });

  ResetPasswordState copyWith({
    String? currentPassword,
    String? newPassword,
    String? confirmPassword,
    ResetPasswordStatus? status,
    String? errorMessage,
    bool? isValid,
  }) {
    return ResetPasswordState(
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object?> get props => [
    currentPassword,
    newPassword,
    confirmPassword,
    status,
    errorMessage,
    isValid,
  ];
}
