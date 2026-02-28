import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import '../helpers/extensions/responsive_extensions.dart';

/// Reusable month calendar widget for filtering data by month
/// Features:
/// - Compact design with circular navigation buttons
/// - Month navigation (previous/next)
/// - Responsive design
/// - High performance with const constructors
/// - Minimal rebuilds
class MonthCalendar extends StatelessWidget {
  final DateTime selectedMonth;
  final ValueChanged<DateTime> onMonthChanged;

  const MonthCalendar({
    super.key,
    required this.selectedMonth,
    required this.onMonthChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.scale(16),
        vertical: context.scaleHeight(12),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: context.scale(12),
        vertical: context.scaleHeight(6),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.scale(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Previous month button
          _MonthNavigationButton(
            icon: Icons.chevron_left,
            onTap: _onPreviousMonth,
          ),

          // Month and year display
          Expanded(
            child: Center(
              child: Text(
                DateFormat('MMMM, yyyy').format(selectedMonth),
                style: TextStyle(
                  fontSize: context.scaleFont(15),
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ),

          // Next month button
          _MonthNavigationButton(
            icon: Icons.chevron_right,
            onTap: _onNextMonth,
          ),
        ],
      ),
    );
  }

  void _onPreviousMonth() {
    final previousMonth = DateTime(
      selectedMonth.year,
      selectedMonth.month - 1,
      1,
    );
    onMonthChanged(previousMonth);
  }

  void _onNextMonth() {
    final nextMonth = DateTime(selectedMonth.year, selectedMonth.month + 1, 1);
    onMonthChanged(nextMonth);
  }
}

/// Circular navigation button for month calendar
class _MonthNavigationButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _MonthNavigationButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(context.scale(20)),
      child: Container(
        width: context.scale(30),
        height: context.scale(30),
        decoration: BoxDecoration(
          color: context.colors.primary.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: context.scale(20), color: Colors.black87),
      ),
    );
  }
}
