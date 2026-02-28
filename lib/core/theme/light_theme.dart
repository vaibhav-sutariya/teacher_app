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
  Color get primary => const Color(0xFF0D078B); // Base color #050076

  @override
  Color get primary2nd => const Color(0xFF0A00B8); // Lighter

  @override
  Color get primary3rd => const Color(0xFF0F00F0); // Lighter

  @override
  Color get primary4th => const Color(0xFF1A1AFF); // Lightest

  @override
  Color get primary5th => const Color(0xFF04005F); // Darker

  @override
  Color get primary6th => const Color(0xFF03004A); // Darkest

  @override
  Color get secondary => const Color(0xFF00B8FF); // Cyan blue

  @override
  Color get secondary2nd => const Color(0xFF00A3E0); // Darker cyan

  @override
  Color get secondary3rd => const Color(0xFF008FC2); // Darker

  @override
  Color get secondary4th => const Color(0xFF007BA5); // Darker

  @override
  Color get secondary5th => const Color(0xFF006788); // Darker

  @override
  Color get secondary6th => const Color(0xFF00536B); // Darkest

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
}
