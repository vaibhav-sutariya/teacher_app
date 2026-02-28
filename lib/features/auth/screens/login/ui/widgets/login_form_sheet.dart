import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/routes/app_router.gr.dart';
import '../../../../../../core/utils/app_validators.dart';
import '../../../../../../core/widgets/app_primary_button.dart';
import '../../../../../../core/widgets/app_text_field.dart';
import '../../../../../../cubit/theme_cubit.dart';
import 'login_tab_switcher.dart';

class LoginFormSheet extends StatefulWidget {
  const LoginFormSheet({super.key});

  @override
  State<LoginFormSheet> createState() => _LoginFormSheetState();
}

class _LoginFormSheetState extends State<LoginFormSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<int> _tabNotifier = ValueNotifier<int>(0);
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _tabNotifier.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Welcome Back',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: context.colors.primary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Please sign in to your account',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            LoginTabSwitcher(selectedIndexNotifier: _tabNotifier),

            const SizedBox(height: 32),

            Text(
              'LOGIN CREDENTIALS',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: context.colors.primary,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 12),

            Form(
              key: _formKey, // Added Form
              child: ValueListenableBuilder<int>(
                valueListenable: _tabNotifier,
                builder: (context, index, _) {
                  return AppTextField(
                    key: ValueKey(index), // Force unmount/remount on tab switch
                    controller: index == 0
                        ? _phoneController
                        : _emailController,
                    hintText: index == 0 ? 'Phone Number' : 'School Email',
                    prefixIcon: Icon(
                      index == 0
                          ? Icons.phone_android_rounded
                          : Icons.email_rounded,
                      color: const Color(0xFF5C6BC0), // Reference blue-ish
                    ),
                    keyboardType: index == 0
                        ? TextInputType.phone
                        : TextInputType.emailAddress,
                    validator: (value) {
                      // Added Validator
                      if (index == 0) {
                        return AppValidators.validatePhone(value);
                      } else {
                        return AppValidators.validateEmail(value);
                      }
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 24),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Trouble logging in?',
                  style: TextStyle(
                    color: context.colors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const Spacer(), // Push content up, button to bottom area if needed or just space

            AppPrimaryButton(
              onPressed: () {
                // Ensure we check validation
                if (_formKey.currentState?.validate() == true) {
                  if (_tabNotifier.value == 0) {
                    // Phone Number -> Open OTP Verification
                    context.router.push(const VerificationRoute());
                  } else {
                    // Email Address -> Open Password Login
                    final email = _emailController.text; // Use email controller
                    context.router.push(PasswordLoginRoute(email: email));
                  }
                }
              },
              // borderRadius: 30, // Removed to standardize on 16
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Terms & Privacy
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                children: [
                  const TextSpan(
                    text: 'By continuing, you agree to Elite Academy\'s\n',
                  ),
                  TextSpan(
                    text: 'Terms of Service',
                    style: TextStyle(
                      color: Colors.grey[700],
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(
                      color: Colors.grey[700],
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
