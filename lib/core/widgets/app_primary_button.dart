import 'package:flutter/material.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import 'app_loader.dart';

class AppPrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Widget? child;
  final Color? color;
  final Color? textColor;
  final bool fullWidth;
  final double height;
  final double borderRadius;
  final bool isLoading;

  const AppPrimaryButton({
    super.key,
    required this.onPressed,
    this.text = '',
    this.child,
    this.color,
    this.textColor,
    this.fullWidth = true,
    this.height = 55,
    this.borderRadius = 16,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    // We primarily use the theme, but allow overrides.
    // The theme definition in light_theme.dart uses FilledButtonThemeData but the code uses ElevatedButton.
    // In Flutter, FilledButton is the 'new' standard for primary actions.
    // However, AppPrimaryButton currently uses ElevatedButton.
    // Let's migrate it to FilledButton to match the theme definition properly, OR use ElevatedButtonTheme if that's what we want.
    // The LightTheme defines `filledButtonTheme`.
    // Let's try to align with the theme's intent. If the theme defines FilledButton, we should probably use FilledButton.
    // BUT to avoid Breaking Changes if the user really wants ElevatedButton, we should check if we can just style ElevatedButton with the theme.

    // We primarily use the theme, but allow overrides.
    // If the project uses ElevatedButton everywhere, we might stick to it, but then the theme props for filledButton won't apply automatically unless we manually map them.
    // Let's stick to ElevatedButton for now as per the file, BUT apply the theme styles manually if needed,
    // OR switch to FilledButton if that's the intended "Primary" button.
    // Given "AppPrimaryButton", FilledButton is the modern primary.
    // Let's switch to FilledButton if safe, or stick to ElevatedButton and grab theme.filledButtonTheme?.style

    // Actually, let's keep ElevatedButton but try to assume the theme has `elevatedButtonTheme` set up or we bridge it.
    // Wait, looking at `light_theme.dart` (Step 813), it defines `filledButtonTheme` and `outlinedButtonTheme`. It does NOT define `elevatedButtonTheme`.
    // So if we use `ElevatedButton`, it won't pick up the theme styles automatically unless we manualy apply `filledButtonTheme` styles.
    // SWICHING TO `FilledButton` is the correct move for "Primary" actions with that theme data.

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: height,
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: color, // If null, defaults to theme
          // Use the background color or primary color for the disabled state
          // to prevent the button from turning grey/white when loading
          disabledBackgroundColor: color ?? context.colors.primary,
          disabledForegroundColor: textColor ?? Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 2,
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: AppLoader(
                  size: 20,
                  strokeWidth: 1.5,
                  color: Colors.white,
                  center: true,
                ),
              )
            : child ??
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color:
                          textColor, // If null, inherits from FilledButton theme (White)
                    ),
                  ),
      ),
    );
  }
}
