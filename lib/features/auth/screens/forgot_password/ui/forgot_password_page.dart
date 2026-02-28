import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../core/routes/app_router.gr.dart';
import '../../../../../core/widgets/app_primary_button.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../cubit/theme_cubit.dart';
import '../../../common/auth_header.dart';

@RoutePage()
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = context.colors.primary;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const AuthPageHeader(title: 'Forgot Password'),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                padding: const EdgeInsets.all(24),
                child: SafeArea(
                  top: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        'Recovery',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: context.colors.primary,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Enter your email or phone number to reset\nyour password',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 32),
                      const SizedBox(height: 32),
                      AppTextField(
                        controller: _emailController,
                        hintText: 'Email or Phone Number',
                        prefixIcon: const Icon(
                          Icons.alternate_email_rounded,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 32),
                      AppPrimaryButton(
                        onPressed: () {
                          // Mock send link and navigate to NewPassword
                          context.router.push(const NewPasswordRoute());
                        },
                        borderRadius: 16,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Send Reset Link',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.send_rounded,
                              size: 18,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
