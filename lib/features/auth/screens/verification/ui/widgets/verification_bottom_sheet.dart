import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/routes/app_router.gr.dart';
import '../../../../../../core/widgets/app_primary_button.dart';
import '../../../../../../cubit/theme_cubit.dart';
import 'otp_input_row.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

class VerificationBottomSheet extends StatelessWidget {
  const VerificationBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.colors.textInverse,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      padding: const EdgeInsets.all(24),
      child: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Verify Identity',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: context.colors.primary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontSize: 14,
                  color: context.colors.textSecondary,
                ),
                children: [
                  TextSpan(
                    text:
                        'A 4-digit security code has been sent to\nyour registered number ',
                  ),
                  TextSpan(
                    text: '+1 ••• ••• 88',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: context.colors.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: OtpInputRow(),
            ),

            const SizedBox(height: 32),

            Center(
              child: Text(
                'Didn\'t receive the code?',
                style: TextStyle(
                  color: context.colors.textSecondary,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 12),

            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F6F9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 16,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Resend in 00:55',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            AppPrimaryButton(
              onPressed: () {
                // Verify Action
                context.router.push(DashboardRoute());
              },
              // borderRadius: 16, // Already default, can function without explicitness, but file had 16. Cleaning up consistency.
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Verify & Proceed',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: context.colors.textInverse,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 20,
                    color: context.colors.textInverse,
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
