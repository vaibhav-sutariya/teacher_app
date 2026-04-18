import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';
import 'package:teachers_app/core/widgets/text_field.dart' as app_text_field;
import 'package:teachers_app/cubit/theme_cubit.dart';

import '../bloc/reset_password_bloc.dart';
import '../bloc/reset_password_event.dart';
import '../bloc/reset_password_state.dart';

@RoutePage()
class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordBloc(),
      child: const ResetPasswordView(),
    );
  }
}

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(title: 'Reset Password'),
      body: BlocListener<ResetPasswordBloc, ResetPasswordState>(
        listener: (context, state) {
          if (state.status == ResetPasswordStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Password reset successfully'),
                backgroundColor: context.colors.success,
              ),
            );
            context.router.maybePop();
          } else if (state.status == ResetPasswordStatus.error &&
              state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: context.colors.error,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: context.scale(20),
            vertical: context.scaleHeight(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Create New Password',
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colors.primary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: context.scaleHeight(8)),
              Text(
                'Your new password must be different from previous used passwords.',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colors.surface500,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: context.scaleHeight(40)),

              // Current Password Field
              BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
                buildWhen: (previous, current) =>
                    previous.currentPassword != current.currentPassword,
                builder: (context, state) {
                  return app_text_field.TextField(
                    hintName: 'Current Password',
                    isObscureText: true,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {
                      context.read<ResetPasswordBloc>().add(
                        CurrentPasswordChanged(value),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: context.scaleHeight(20)),

              // New Password Field
              BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
                buildWhen: (previous, current) =>
                    previous.newPassword != current.newPassword,
                builder: (context, state) {
                  return app_text_field.TextField(
                    hintName: 'New Password',
                    isObscureText: true,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {
                      context.read<ResetPasswordBloc>().add(
                        NewPasswordChanged(value),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: context.scaleHeight(20)),

              // Confirm Password Field
              BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
                buildWhen: (previous, current) =>
                    previous.confirmPassword != current.confirmPassword,
                builder: (context, state) {
                  return app_text_field.TextField(
                    hintName: 'Confirm New Password',
                    isObscureText: true,
                    textInputAction: TextInputAction.done,
                    onChanged: (value) {
                      context.read<ResetPasswordBloc>().add(
                        ConfirmPasswordChanged(value),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: context.scaleHeight(40)),

              // Submit Button
              BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
                builder: (context, state) {
                  return FilledButton(
                    onPressed:
                        state.isValid &&
                            state.status != ResetPasswordStatus.submitting
                        ? () {
                            // Unfocus keyboard
                            FocusManager.instance.primaryFocus?.unfocus();
                            context.read<ResetPasswordBloc>().add(
                              SubmitResetPassword(),
                            );
                          }
                        : null,
                    child: state.status == ResetPasswordStatus.submitting
                        ? SizedBox(
                            width: context.scale(24),
                            height: context.scale(24),
                            child: CircularProgressIndicator(
                              color: context.colors.textInverse,
                              strokeWidth: 2.5,
                            ),
                          )
                        : const Text('Reset Password'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
