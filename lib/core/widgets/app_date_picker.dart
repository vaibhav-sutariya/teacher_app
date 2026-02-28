import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../cubit/theme_cubit.dart';
import '../helpers/extensions/responsive_extensions.dart';

/// Globally reusable date picker widget
/// Features:
/// - Material date picker integration
/// - Custom styling matching app theme
/// - Reusable across entire project
/// - Performance optimized with const constructors
class AppDatePicker {
  /// Show date picker and return selected date
  ///
  /// [context] - Build context for showing picker
  /// [initialDate] - Initially selected date (defaults to today)
  /// [firstDate] - Earliest selectable date
  /// [lastDate] - Latest selectable date
  /// [helpText] - Header text in picker
  static Future<DateTime?> show(
    BuildContext context, {
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    String? helpText,
  }) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final effectiveFirstDate = firstDate ?? DateTime(2000);
    final effectiveLastDate = lastDate ?? DateTime(2100);

    // Ensure initialDate is within valid range
    DateTime effectiveInitialDate = initialDate ?? today;
    if (effectiveInitialDate.isBefore(effectiveFirstDate)) {
      effectiveInitialDate = effectiveFirstDate;
    } else if (effectiveInitialDate.isAfter(effectiveLastDate)) {
      effectiveInitialDate = effectiveLastDate;
    }

    return await showDatePicker(
      context: context,
      initialDate: effectiveInitialDate,
      firstDate: effectiveFirstDate,
      lastDate: effectiveLastDate,
      helpText: helpText ?? 'Select Date',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: context.colors.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black87,
            ),
            dialogTheme: DialogThemeData(
              backgroundColor: Colors.white,
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: context.colors.primary,
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            datePickerTheme: DatePickerThemeData(
              backgroundColor: Colors.white,
              headerBackgroundColor: context.colors.primary,
              headerForegroundColor: Colors.white,
              dayStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              yearStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
  }
}

/// Date picker field widget
/// Displays selected date and opens picker on tap
class AppDatePickerField extends StatelessWidget {
  final String label;
  final DateTime? selectedDate;
  final ValueChanged<DateTime?> onDateSelected;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? Function(DateTime?)? validator;
  final bool enabled;
  final String? errorText;

  const AppDatePickerField({
    super.key,
    required this.label,
    required this.selectedDate,
    required this.onDateSelected,
    this.firstDate,
    this.lastDate,
    this.validator,
    this.enabled = true,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final dateText = selectedDate != null
        ? DateFormat('dd MMM yyyy').format(selectedDate!)
        : null;

    final theme = Theme.of(context);
    final inputDecorationTheme = theme.inputDecorationTheme;

    // Use same color logic as AppTextField
    final effectiveColor =
        inputDecorationTheme.fillColor ?? const Color(0xFFF8F9FB);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(bottom: context.scaleHeight(8)),
            child: RichText(
              text: TextSpan(
                text: label,
                style: TextStyle(
                  fontSize: context.scaleFont(14),
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                children: [
                  if (validator != null)
                    TextSpan(
                      text: ' *',
                      style: TextStyle(color: context.colors.error),
                    ),
                ],
              ),
            ),
          ),
        InkWell(
          onTap: enabled ? () => _showPicker(context) : null,
          borderRadius: BorderRadius.circular(context.scale(16)),
          child: InputDecorator(
            decoration: InputDecoration(
              filled: true,
              fillColor: effectiveColor,
              contentPadding: EdgeInsets.symmetric(
                horizontal: context.scale(16),
                vertical: context.scaleHeight(10),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.scale(16)),
                borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.scale(16)),
                borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.scale(16)),
                borderSide: BorderSide(color: context.colors.primary),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.scale(16)),
                borderSide: BorderSide(color: context.colors.error),
              ),
              errorText: errorText,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: context.scale(18),
                  color: context.colors.primary,
                ),
                SizedBox(width: context.scale(12)),
                Expanded(
                  child: Text(
                    dateText ?? 'Select Date',
                    style: TextStyle(
                      fontSize: context.scaleFont(14),
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showPicker(BuildContext context) async {
    final date = await AppDatePicker.show(
      context,
      initialDate: selectedDate,
      firstDate: firstDate,
      lastDate: lastDate,
      helpText: label,
    );

    if (date != null) {
      onDateSelected(date);
    }
  }
}
