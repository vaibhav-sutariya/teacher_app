import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../style/text_styles.dart';
import 'app_theme.dart';

class LightTheme extends AppTheme {
  @override
  AppColors get colors => LightColors();

  @override
  FilledButtonThemeData get filledButtonTheme => FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: colors.primary,
      foregroundColor: colors.buttonTextColor,
      padding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      textStyle: TextStyles.titleLarge,
      disabledBackgroundColor: colors.surface100,
      disabledForegroundColor: colors.primary,
    ),
  );

  @override
  OutlinedButtonThemeData get outlinedButtonTheme => OutlinedButtonThemeData(
    style:
        OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: colors.primary,
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: TextStyles.titleLarge,
          disabledForegroundColor: colors.surface100,
        ).copyWith(
          side: WidgetStateBorderSide.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return BorderSide(color: colors.surface200);
            }
            return BorderSide(color: colors.primary);
          }),
        ),
  );

  @override
  InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFFF8F9FB), // Matches NewPasswordPage standard
    suffixIconColor: colors.surface500,
    labelStyle: TextStyles.labelMedium.copyWith(
      color: colors.surface400,
      fontWeight: FontWeight.w400,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: colors.primary),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: colors.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: colors.error),
    ),
  );

  @override
  AppBarTheme get appBarTheme => AppBarTheme(
    backgroundColor: colors.background,
    foregroundColor: colors.surface900,
    titleTextStyle: TextStyles.labelMedium,
  );

  @override
  BottomNavigationBarThemeData get bottomNavigationBarThemeData =>
      BottomNavigationBarThemeData(
        backgroundColor: colors.background,
        selectedItemColor: colors.primary,
        unselectedItemColor: colors.surface500,
        selectedLabelStyle: TextStyles.bodySmall,
        unselectedLabelStyle: TextStyles.bodySmall,
      );

  @override
  TextTheme get textTheme => TextTheme(
    headlineLarge: TextStyles.headlineLarge,
    headlineMedium: TextStyles.headlineMedium,
    headlineSmall: TextStyles.headlineSmall,
    displayLarge: TextStyles.displayLarge,
    displayMedium: TextStyles.displayMedium,
    displaySmall: TextStyles.displaySmall,
    labelLarge: TextStyles.labelLarge,
    labelMedium: TextStyles.labelMedium,
    labelSmall: TextStyles.labelSmall,
    titleLarge: TextStyles.titleLarge,
    titleMedium: TextStyles.titleMedium,
    titleSmall: TextStyles.titleSmall,
    bodyLarge: TextStyles.bodyLarge,
    bodyMedium: TextStyles.bodyMedium,
    bodySmall: TextStyles.bodySmall,
  );

  @override
  ThemeData get theme => ThemeData(
    scaffoldBackgroundColor: colors.background,
    useMaterial3: true,
    appBarTheme: appBarTheme,
    filledButtonTheme: filledButtonTheme,
    outlinedButtonTheme: outlinedButtonTheme,
    textTheme: textTheme,
    fontFamily: GoogleFonts.radioCanada().fontFamily,
    inputDecorationTheme: inputDecorationTheme,
    bottomNavigationBarTheme: bottomNavigationBarThemeData,
  );
}

class LightColors extends AppColors {
  @override
  Color get primary => const Color(0xFF066046); // Base color

  @override
  Color get primary2nd => const Color(0xFF0A916A); // Lighter

  @override
  Color get primary3rd => const Color(0xFF0EC28E); // Lighter

  @override
  Color get primary4th => const Color(0xFF14F5B4); // Lightest

  @override
  Color get primary5th => const Color(0xFF044532); // Darker

  @override
  Color get primary6th => const Color(0xFF022B1F); // Darkest

  @override
  Color get secondary => const Color(0xFF10B981); // Emerald Green

  @override
  Color get secondary2nd => const Color(0xFF059669); // Darker emerald

  @override
  Color get secondary3rd => const Color(0xFF047857); // Darker

  @override
  Color get secondary4th => const Color(0xFF065F46); // Darker

  @override
  Color get secondary5th => const Color(0xFF064E3B); // Darker

  @override
  Color get secondary6th => const Color(0xFF022C22); // Darkest

  @override
  Color get success => const Color(0xFF22C55E);

  @override
  Color get warning => const Color(0xFFFACC15);

  @override
  Color get error => const Color(0xFFEF4444);

  @override
  Color get surface => const Color(0xFFF8FAFC);

  @override
  Color get surface50 => const Color(0xFFFEFEFE);

  @override
  Color get surface100 => const Color(0xFFF8FAFC);

  @override
  Color get surface200 => const Color(0xFFE2E8F0);

  @override
  Color get surface300 => const Color(0xFFCBD5E1);

  @override
  Color get surface400 => const Color(0xFF94A3B8);

  @override
  Color get surface500 => const Color(0xFF64748B);

  @override
  Color get surface600 => const Color(0xFF475569);

  @override
  Color get surface700 => const Color(0xFF334155);

  @override
  Color get surface800 => const Color(0xFF1E293B);

  @override
  Color get surface900 => const Color(0xFF0F172A);

  @override
  Color get background => const Color(0xFFFFFFFF);

  @override
  Color get buttonTextColor => const Color(0xFFFFFFFF);

  @override
  Color get textPrimary => const Color(0xFF1E293B); // surface800

  @override
  Color get textSecondary => const Color(0xFF64748B); // surface500

  @override
  Color get textTertiary => const Color(0xFF94A3B8); // surface400

  @override
  Color get textInverse => const Color(0xFFFFFFFF); // white text

  @override
  Color get border => const Color(0xFFE2E8F0); // surface200

  @override
  Color get divider => const Color(0xFFE2E8F0); // surface200 (light divider)

  @override
  Color get textBody => const Color(0xFF546E7A); // Blue-grey body text

  @override
  Color get textCaption => const Color(0xFF78909C); // Blue-grey caption text

  @override
  Color get successDark => const Color(0xFF2E7D32); // Dark green

  @override
  Color get successLight => const Color(0xFFE8F5E9); // Light green bg

  @override
  Color get errorDark => const Color(0xFFC62828); // Dark red

  @override
  Color get errorLight => const Color(0xFFFFEBEE); // Light red bg

  @override
  Color get warningDark => const Color(0xFFF57C00); // Dark amber

  @override
  Color get warningLight => const Color(0xFFFFF3E0); // Light amber bg

  @override
  Color get infoLight => const Color(0xFFE3F2FD); // Light blue bg

  @override
  Color get surfaceLight => const Color(0xFFF8F9FA); // Very light grey

  @override
  Color get surfaceMedium => const Color(0xFFF3F5F7); // Medium grey

  @override
  Color get iconDefault => const Color(0xFF233240); // Dark navy icon
}
