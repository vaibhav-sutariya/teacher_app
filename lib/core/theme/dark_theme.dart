import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../style/text_styles.dart';
import 'app_theme.dart';

class DarkTheme extends AppTheme {
  @override
  AppColors get colors => DarkColors();

  @override
  FilledButtonThemeData get filledButtonTheme => FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: colors.primary, // White
      foregroundColor: colors.buttonTextColor, // Dark blue
      padding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      textStyle: TextStyles.titleLarge,
      disabledBackgroundColor: colors.surface300, // Medium blue-gray
      disabledForegroundColor: colors.surface500, // Lighter blue-gray
    ),
  );

  @override
  OutlinedButtonThemeData get outlinedButtonTheme => OutlinedButtonThemeData(
    style:
        OutlinedButton.styleFrom(
          backgroundColor:
              Colors.transparent, // Transparent for outlined button
          foregroundColor: colors.primary, // White text
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: TextStyles.titleLarge,
          disabledForegroundColor: colors.surface500, // Lighter blue-gray
        ).copyWith(
          side: WidgetStateBorderSide.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return BorderSide(color: colors.surface300); // Medium blue-gray
            }
            return BorderSide(color: colors.primary); // White border
          }),
        ),
  );

  @override
  InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
    filled: true,
    fillColor: colors.surface50, // Dark blue for input fields
    suffixIconColor: colors.surface400,
    labelStyle: TextStyles.labelMedium.copyWith(
      color: Colors.white70, // Slightly transparent white for labels
      fontWeight: FontWeight.w400,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: colors.primary),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.transparent),
    ),
  );

  @override
  AppBarTheme get appBarTheme => AppBarTheme(
    backgroundColor: colors.background,
    foregroundColor: Colors.white, // White for good contrast
    titleTextStyle: TextStyles.labelMedium.copyWith(color: Colors.white),
  );

  @override
  BottomNavigationBarThemeData get bottomNavigationBarThemeData =>
      BottomNavigationBarThemeData(
        backgroundColor: colors.background,
        selectedItemColor: colors.primary, // White
        unselectedItemColor: Colors.white70, // White with slight transparency
        selectedLabelStyle: TextStyles.bodySmall.copyWith(
          color: colors.primary, // White
        ),
        unselectedLabelStyle: TextStyles.bodySmall.copyWith(
          color: Colors.white70,
        ),
      );

  @override
  TextTheme get textTheme => TextTheme(
    headlineLarge: TextStyles.headlineLarge.copyWith(color: Colors.white),
    headlineMedium: TextStyles.headlineMedium.copyWith(color: Colors.white),
    headlineSmall: TextStyles.headlineSmall.copyWith(color: Colors.white),
    displayLarge: TextStyles.displayLarge.copyWith(color: Colors.white),
    displayMedium: TextStyles.displayMedium.copyWith(color: Colors.white),
    displaySmall: TextStyles.displaySmall.copyWith(color: Colors.white),
    labelLarge: TextStyles.labelLarge.copyWith(color: Colors.white),
    labelMedium: TextStyles.labelMedium.copyWith(color: Colors.white),
    labelSmall: TextStyles.labelSmall.copyWith(color: Colors.white),
    titleLarge: TextStyles.titleLarge.copyWith(color: Colors.white),
    titleMedium: TextStyles.titleMedium.copyWith(color: Colors.white),
    titleSmall: TextStyles.titleSmall.copyWith(color: Colors.white),
    bodyLarge: TextStyles.bodyLarge.copyWith(color: Colors.white),
    bodyMedium: TextStyles.bodyMedium.copyWith(color: Colors.white),
    bodySmall: TextStyles.bodySmall.copyWith(color: Colors.white),
  );

  @override
  ThemeData get theme => ThemeData(
    scaffoldBackgroundColor: colors.background,
    useMaterial3: true,
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      backgroundColor: colors.background,
      foregroundColor: Colors.white,
      titleTextStyle: TextStyles.labelMedium.copyWith(color: Colors.white),
    ),
    fontFamily: GoogleFonts.radioCanada().fontFamily,
    filledButtonTheme: filledButtonTheme,
    outlinedButtonTheme: outlinedButtonTheme,
    textTheme: textTheme,
    inputDecorationTheme: inputDecorationTheme,
  );
}

class DarkColors extends AppColors {
  @override
  Color get primary => const Color(0xFFFFFFFF); // White for dark theme

  @override
  Color get primary2nd => const Color(0xFFF5F5F5); // Light gray

  @override
  Color get primary3rd => const Color(0xFFE0E0E0); // Lighter gray

  @override
  Color get primary4th => const Color(0xFFBDBDBD); // Light gray

  @override
  Color get primary5th => const Color(0xFF9E9E9E); // Medium gray

  @override
  Color get primary6th => const Color(0xFF757575); // Dark gray

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
  Color get surface => const Color(0xFF03004A); // Dark blue surface

  @override
  Color get surface50 => const Color(0xFF04005F); // Slightly lighter

  @override
  Color get surface100 => const Color(0xFF050076); // Primary color

  @override
  Color get surface200 => const Color(0xFF0A00B8); // Lighter blue

  @override
  Color get surface300 => const Color(0xFF1A1AFF); // Lighter

  @override
  Color get surface400 => const Color(0xFF3333FF); // Lighter

  @override
  Color get surface500 => const Color(0xFF4D4DFF); // Lighter

  @override
  Color get surface600 => const Color(0xFF6666FF); // Lighter

  @override
  Color get surface700 => const Color(0xFF8080FF); // Lighter

  @override
  Color get surface800 => const Color(0xFF9999FF); // Lighter

  @override
  Color get surface900 => const Color(0xFFB3B3FF); // Lightest blue

  @override
  Color get background => const Color(0xFF020035); // Very dark blue background

  @override
  Color get buttonTextColor => const Color(0xFF020035); // Dark blue text for white buttons
}
