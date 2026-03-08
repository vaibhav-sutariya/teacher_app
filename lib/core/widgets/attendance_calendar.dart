import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import '../helpers/extensions/responsive_extensions.dart';

/// Attendance status enum for calendar dates
enum AttendanceStatus { present, absent, holiday, notMarked }

/// Calendar date data model
class CalendarDateData {
  final DateTime date;
  final AttendanceStatus status;

  const CalendarDateData({required this.date, required this.status});
}

/// Production-ready reusable attendance calendar component
/// Optimized for performance with minimal rebuilds
class AttendanceCalendar extends StatefulWidget {
  /// Current selected date
  final DateTime? selectedDate;

  /// Map of dates to their attendance status
  final Map<DateTime, AttendanceStatus> attendanceData;

  /// Callback when a date is selected
  final ValueChanged<DateTime>? onDateSelected;

  /// Callback when month changes
  final ValueChanged<DateTime>? onMonthChanged;

  /// Academic year text (e.g., "ACADEMIC YEAR 23/24")
  final String? academicYear;

  /// Builder for custom day cell
  final Widget Function(BuildContext, DateTime, bool, bool)? dayBuilder;

  /// Custom padding for the card
  final EdgeInsetsGeometry? padding;

  /// Custom margin for the card
  final EdgeInsetsGeometry? margin;

  /// Whether to show the card elevation
  final bool showElevation;

  /// Whether to show the legend
  final bool showLegend;

  /// Whether to allow selecting future dates
  final bool allowFutureDates;

  const AttendanceCalendar({
    super.key,
    this.selectedDate,
    this.attendanceData = const {},
    this.onDateSelected,
    this.onMonthChanged,
    this.academicYear,
    this.dayBuilder,
    this.padding,
    this.margin,
    this.showElevation = true,
    this.showLegend = true,
    this.allowFutureDates = false,
  });

  @override
  State<AttendanceCalendar> createState() => _AttendanceCalendarState();
}

class _AttendanceCalendarState extends State<AttendanceCalendar> {
  late DateTime _currentMonth;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime.now();
    _selectedDate = widget.selectedDate ?? DateTime.now();
  }

  @override
  void didUpdateWidget(AttendanceCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDate != oldWidget.selectedDate &&
        widget.selectedDate != null) {
      _selectedDate = widget.selectedDate!;
      _currentMonth = DateTime(_selectedDate.year, _selectedDate.month);
    }
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
    widget.onMonthChanged?.call(_currentMonth);
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
    widget.onMonthChanged?.call(_currentMonth);
  }

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
    widget.onDateSelected?.call(date);
  }

  List<DateTime> _getDaysInMonth() {
    final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final lastDay = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);
    // Convert weekday to Sunday-based (0 = Sunday, 6 = Saturday)
    // DateTime.weekday: 1 = Monday, 7 = Sunday
    // We want: 0 = Sunday, 6 = Saturday
    final firstDayOfWeek =
        firstDay.weekday % 7; // 0 = Sunday, 1-6 = Monday-Saturday

    final days = <DateTime>[];

    // Add empty slots for days before the first day of the month (to align with Sunday start)
    for (int i = 0; i < firstDayOfWeek; i++) {
      days.add(DateTime(0)); // Placeholder for empty cells
    }

    // Add all current month's days (future dates will be disabled in the UI)
    for (int i = 1; i <= lastDay.day; i++) {
      days.add(DateTime(_currentMonth.year, _currentMonth.month, i));
    }

    // Don't add next month's dates - grid will end naturally

    return days;
  }

  Color _getStatusColor(BuildContext context, AttendanceStatus status) {
    switch (status) {
      case AttendanceStatus.present:
        return context.colors.success;
      case AttendanceStatus.absent:
        return context.colors.error;
      case AttendanceStatus.holiday:
        return context.colors.warningDark;
      case AttendanceStatus.notMarked:
        return Colors.transparent;
    }
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  bool _isCurrentMonth(DateTime date) {
    return date.month == _currentMonth.month && date.year == _currentMonth.year;
  }

  @override
  Widget build(BuildContext context) {
    final days = _getDaysInMonth();
    final monthYear = DateFormat('MMMM yyyy').format(_currentMonth);

    return Card(
      color: Colors.white,
      elevation: widget.showElevation ? 2 : 0,
      shadowColor: widget.showElevation
          ? Colors.black.withValues(alpha: 0.1)
          : Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.scale(20)),
      ),
      margin:
          widget.margin ?? EdgeInsets.symmetric(horizontal: context.scale(16)),
      child: Padding(
        padding: widget.padding ?? EdgeInsets.all(context.scale(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Month navigation header
            _buildMonthHeader(context, monthYear),
            SizedBox(height: context.scaleHeight(16)),
            // Days of week header
            _buildDaysOfWeekHeader(context),
            SizedBox(height: context.scaleHeight(8)),
            // Calendar grid
            _buildCalendarGrid(context, days),
            if (widget.showLegend) ...[
              SizedBox(height: context.scaleHeight(16)),
              // Legend
              _buildLegend(context),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMonthHeader(BuildContext context, String monthYear) {
    final monthTextStyle = TextStyle(
      fontSize: context.scaleFont(18),
      fontWeight: FontWeight.bold,
      color: context.colors.primary,
    );

    // Check if next month is allowed
    // Allowed if allowFutureDates is true OR current month is before current real month
    final now = DateTime.now();
    final currentRealMonth = DateTime(now.year, now.month);
    final isNextMonthAllowed =
        widget.allowFutureDates || _currentMonth.isBefore(currentRealMonth);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Container(
            width: context.scale(30),
            height: context.scale(30),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.colors.primary.withValues(alpha: 0.1),
            ),
            child: Icon(
              Icons.chevron_left,
              color: context.colors.primary,
              size: context.scale(20),
            ),
          ),
          onPressed: _previousMonth,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        Text(monthYear, style: monthTextStyle),
        IconButton(
          icon: Container(
            width: context.scale(30),
            height: context.scale(30),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isNextMonthAllowed
                  ? context.colors.primary.withValues(alpha: 0.1)
                  : Colors.grey.withValues(alpha: 0.1),
            ),
            child: Icon(
              Icons.chevron_right,
              color: isNextMonthAllowed
                  ? Colors.black87
                  : Colors.grey.withValues(alpha: 0.5),
              size: context.scale(20),
            ),
          ),
          onPressed: isNextMonthAllowed ? _nextMonth : null,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }

  Widget _buildDaysOfWeekHeader(BuildContext context) {
    // Start with Sunday (0 = Sunday, 6 = Saturday)
    const daysOfWeek = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
    final textStyle = TextStyle(
      fontSize: context.scaleFont(12),
      fontWeight: FontWeight.w600,
      color: Colors.grey[700],
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: daysOfWeek.map((day) {
        return Expanded(
          child: Center(child: Text(day, style: textStyle)),
        );
      }).toList(),
    );
  }

  Widget _buildCalendarGrid(BuildContext context, List<DateTime> days) {
    return GridView.builder(
      padding: EdgeInsets.zero, // Remove default padding
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: context.scaleHeight(4), // Reduced spacing
        crossAxisSpacing: context.scale(4), // Reduced spacing
        childAspectRatio: 1.1, // Make cells slightly wider to reduce height
      ),
      itemCount: days.length,
      itemBuilder: (context, index) {
        final date = days[index];

        // Skip empty placeholder dates (DateTime(0))
        if (date.year == 0) {
          return const SizedBox.shrink();
        }

        final isCurrentMonth = _isCurrentMonth(date);
        final isSelected = _isSameDay(date, _selectedDate);
        // Normalize date for lookup (year, month, day only)
        final normalizedDate = DateTime(date.year, date.month, date.day);

        // Check if it's Sunday (weekday == 7) - always mark as holiday
        final isSunday = date.weekday == 7;
        final status = isSunday
            ? AttendanceStatus.holiday
            : (widget.attendanceData[normalizedDate] ??
                  AttendanceStatus.notMarked);
        final hasStatus = status != AttendanceStatus.notMarked;

        if (widget.dayBuilder != null) {
          return GestureDetector(
            onTap: () {
              // Determine if selectable logic matches _buildDateCell
              final today = DateTime.now();
              final normalizedDate = DateTime(date.year, date.month, date.day);
              final normalizedToday = DateTime(
                today.year,
                today.month,
                today.day,
              );
              final isFutureDate = normalizedDate.isAfter(normalizedToday);
              // Allow selection based on similar logic or just pass tap
              // Allow selection if not future date OR if future dates are allowed
              if (!isFutureDate || widget.allowFutureDates) {
                _selectDate(date);
              } else {
                // If user wants to allow future dates selection for events, we might need to change this logic.
                // For now, let's assume the caller handles logic or we use standard logic.
                // Wait, for Calendar Page we DO want to select future dates!
                // The existing logic inside _buildDateCell restricts future dates.
                // We should probably allow the builder to handle tap or provide a param `allowFutureDates`.
                // But to keep it simple and not break attendance, let's use the builder's tap if possible?
                // Actually, let's just delegate the UI building. The onTap logic is inside _buildDateCell.
                // If we use dayBuilder, we should wrap it with GestureDetector.
                _selectDate(date);
              }
            },
            child: widget.dayBuilder!(
              context,
              date,
              isSelected,
              isCurrentMonth,
            ),
          );
        }

        return _buildDateCell(
          context,
          date,
          isCurrentMonth,
          isSelected,
          status,
          hasStatus,
        );
      },
    );
  }

  Widget _buildDateCell(
    BuildContext context,
    DateTime date,
    bool isCurrentMonth,
    bool isSelected,
    AttendanceStatus status,
    bool hasStatus,
  ) {
    final dateText = date.day.toString();
    final isToday = _isSameDay(date, DateTime.now());
    final today = DateTime.now();
    final normalizedDate = DateTime(date.year, date.month, date.day);
    final normalizedToday = DateTime(today.year, today.month, today.day);
    final isFutureDate = normalizedDate.isAfter(normalizedToday);
    final isSelectable = !isFutureDate || widget.allowFutureDates;
    final isSunday = date.weekday == 7;

    // Sundays are always holidays, so always show holiday color
    final effectiveStatus = isSunday ? AttendanceStatus.holiday : status;
    final effectiveHasStatus = isSunday || hasStatus;

    return GestureDetector(
      onTap: isSelectable ? () => _selectDate(date) : null,
      child: Opacity(
        // Reduce opacity for future dates (not Sundays) only if future dates NOT allowed
        opacity: isFutureDate && !isSunday && !widget.allowFutureDates
            ? 0.4
            : 1.0,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected
                ? context.colors.primary
                : effectiveHasStatus
                ? _getStatusColor(context, effectiveStatus)
                : Colors.transparent,
            // Add border for today's date when not selected
            border: isToday && !isSelected
                ? Border.all(color: context.colors.primary, width: 2)
                : null,
          ),
          child: Center(
            child: Text(
              dateText,
              style: TextStyle(
                fontSize: context.scaleFont(13),
                fontWeight: isSelected || effectiveHasStatus
                    ? FontWeight.w600
                    : FontWeight.normal,
                color: isSelected
                    ? Colors.white
                    : isFutureDate && !isSunday
                    ? Colors.grey[400]!
                    : effectiveHasStatus
                    ? Colors.white
                    : Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLegend(BuildContext context) {
    final legendTextStyle = TextStyle(
      fontSize: context.scaleFont(11),
      color: Colors.grey[700],
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegendItem(
          context,
          context.colors.success,
          'PRESENT',
          legendTextStyle,
        ),
        SizedBox(width: context.scale(16)),
        _buildLegendItem(
          context,
          context.colors.error,
          'ABSENT',
          legendTextStyle,
        ),
        SizedBox(width: context.scale(16)),
        _buildLegendItem(
          context,
          context.colors.warningDark,
          'HOLIDAY',
          legendTextStyle,
        ),
      ],
    );
  }

  Widget _buildLegendItem(
    BuildContext context,
    Color color,
    String label,
    TextStyle textStyle,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: context.scale(12),
          height: context.scale(12),
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: context.scale(6)),
        Text(label, style: textStyle),
      ],
    );
  }
}
