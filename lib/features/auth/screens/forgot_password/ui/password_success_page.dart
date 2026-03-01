import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../core/routes/app_router.gr.dart';
import '../../../../../core/widgets/app_primary_button.dart';
import '../../../../../cubit/theme_cubit.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

@RoutePage()
class PasswordSuccessPage extends StatelessWidget {
  const PasswordSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = context.colors.primary;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: context.colors.textInverse,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Color(0xFF00C853), // Green
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_rounded,
                      color: context.colors.textInverse,
                      size: 40,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Password Changed!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: context.colors.textInverse,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Your password has been successfully\nreset. You can now login with your\nnew credentials.',
                style: TextStyle(
                  fontSize: 16,
                  color: context.colors.textInverse.withValues(alpha: 0.8),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
              AppPrimaryButton(
                onPressed: () {
                  // Navigate Back to Login (Clear Stack)
                  context.router.replaceAll([const LoginRoute()]);
                },
                color: context.colors.textInverse,
                borderRadius: 30,
                child: Text(
                  'Back to Login',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: context.colors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
