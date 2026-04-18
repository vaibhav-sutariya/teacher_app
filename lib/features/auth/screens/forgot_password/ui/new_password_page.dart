import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:teachers_app/core/routes/app_router.gr.dart';

import '../../../../../core/widgets/app_primary_button.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../cubit/theme_cubit.dart';
import '../../login/ui/widgets/auth_header.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

@RoutePage()
class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  final ValueNotifier<bool> _isLengthValid = ValueNotifier(false);
  final ValueNotifier<bool> _isSymbolValid = ValueNotifier(false);
  final ValueNotifier<bool> _isUpperValid = ValueNotifier(false);

  bool _hidePass = true;
  bool _hideConfirm = true;

  @override
  void initState() {
    super.initState();
    _passController.addListener(_validatePassword);
  }

  void _validatePassword() {
    final pass = _passController.text;
    _isLengthValid.value = pass.length >= 8;
    _isSymbolValid.value = RegExp(r'[0-9!@#\$%^&*(),.?":{}|<>]').hasMatch(pass);
    _isUpperValid.value = RegExp(r'[A-Z]').hasMatch(pass);
  }

  @override
  void dispose() {
    _passController.dispose();
    _confirmController.dispose();
    _isLengthValid.dispose();
    _isSymbolValid.dispose();
    _isUpperValid.dispose();
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
            const AuthPageHeader(title: 'Security'),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: context.colors.textInverse,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                padding: const EdgeInsets.all(24),
                child: SafeArea(
                  top: false,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Create New\nPassword',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: context.colors.primary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Set a strong password to protect your\nschool management account.',
                          style: TextStyle(
                            fontSize: 14,
                            color: context.colors.textSecondary,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 32),

                        const Text(
                          'New Password',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildPasswordField(
                          controller: _passController,
                          hint: 'Enter new password',
                          isObscured: _hidePass,
                          onToggleVisibility: () =>
                              setState(() => _hidePass = !_hidePass),
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          'Confirm New Password',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildPasswordField(
                          controller: _confirmController,
                          hint: 'Confirm your password',
                          isObscured: _hideConfirm,
                          isConfirm: true,
                          onToggleVisibility: () =>
                              setState(() => _hideConfirm = !_hideConfirm),
                        ),

                        const SizedBox(height: 32),

                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: context.colors.surface100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'PASSWORD REQUIREMENTS',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: context.colors.textTertiary,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              const SizedBox(height: 12),
                              _buildRequirementRow(
                                _isLengthValid,
                                'At least 8 characters long',
                              ),
                              const SizedBox(height: 8),
                              _buildRequirementRow(
                                _isSymbolValid,
                                'Contains a symbol or number',
                              ),
                              const SizedBox(height: 8),
                              _buildRequirementRow(
                                _isUpperValid,
                                'One uppercase letter',
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        AppPrimaryButton(
                          onPressed: () {
                            // Validate confirmation and Update
                            if (_passController.text ==
                                    _confirmController.text &&
                                _isLengthValid.value) {
                              context.router.push(const PasswordSuccessRoute());
                            }
                          },
                          borderRadius: 16,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Update Password',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: context.colors.textInverse,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                Icons.cached_rounded,
                                size: 18,
                                color: context.colors.textInverse,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hint,
    required bool isObscured,
    required VoidCallback onToggleVisibility,
    bool isConfirm = false,
  }) {
    return AppTextField(
      controller: controller,
      hintText: hint,
      obscureText: isObscured,
      prefixIcon: Icon(
        isConfirm ? Icons.lock_reset_rounded : Icons.lock_outline_rounded,
        color: context.colors.textTertiary,
        size: 20,
      ),
      suffixIcon: IconButton(
        icon: Icon(
          isObscured
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          color: context.colors.textTertiary,
          size: 20,
        ),
        onPressed: onToggleVisibility,
      ),
      fillColor: context.colors.surface100,
      borderSide:
          null, // Default border handling in widget or override here if needed, AppTextField defaults to greyish border
    );
  }

  Widget _buildRequirementRow(ValueNotifier<bool> validNotifier, String text) {
    return ValueListenableBuilder<bool>(
      valueListenable: validNotifier,
      builder: (context, isValid, _) {
        return Row(
          children: [
            Icon(
              isValid
                  ? Icons.check_circle_rounded
                  : Icons.check_circle_outline_rounded,
              color: isValid
                  ? context.colors.primary
                  : context.colors.textTertiary,
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                color: isValid
                    ? context.colors.textPrimary
                    : context.colors.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        );
      },
    );
  }
}
