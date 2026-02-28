import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/routes/app_router.gr.dart';
import '../../../../../../core/utils/app_validators.dart';
import '../../../../../../core/widgets/app_outlined_button.dart';
import '../../../../../../core/widgets/app_primary_button.dart';
import '../../../../../../core/widgets/app_text_field.dart';
import '../../../../../../cubit/theme_cubit.dart';

class PasswordLoginForm extends StatefulWidget {
  const PasswordLoginForm({super.key});

  @override
  State<PasswordLoginForm> createState() => _PasswordLoginFormState();
}

class _PasswordLoginFormState extends State<PasswordLoginForm> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Added Form Key
  bool _isPasswordVisible = false;
  final TextEditingController _passwordController = TextEditingController();

  // ...
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Password',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1F36),
            ),
          ),
          const SizedBox(height: 8),
          AppTextField(
            controller: _passwordController,
            hintText: '••••••••••',
            obscureText: !_isPasswordVisible,
            validator: AppValidators.validatePassword, // Added Validator
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
              icon: Icon(
                _isPasswordVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // Forgot password logic
                context.router.push(const ForgotPasswordRoute());
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                  color: context.colors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          AppPrimaryButton(
            onPressed: () {
              if (_formKey.currentState?.validate() == true) {
                // Login Logic
              }
            },
            text: 'Login',
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: Divider(color: Colors.grey.withValues(alpha: 0.2)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Trouble logging in?',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                child: Divider(color: Colors.grey.withValues(alpha: 0.2)),
              ),
            ],
          ),
          const SizedBox(height: 32),
          AppOutlinedButton(
            onPressed: () {
              // Navigate to OTP Login
              context.router.pop(); // Go back to Login Sheet (Phone tab)
            },
            text: 'Login with OTP',
          ),
          const SizedBox(height: 60), // Spacer for bottom
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock_rounded, size: 16, color: Colors.grey[500]),
              const SizedBox(width: 8),
              Text(
                'Secure encrypted connection',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
