import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';
import 'package:teachers_app/core/widgets/app_loader.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../core/routes/app_router.gr.dart';
import 'bloc/meal_menu_classes_bloc.dart';
import 'bloc/meal_menu_classes_event.dart';
import 'bloc/meal_menu_classes_state.dart';

@RoutePage()
class MealMenuClassesPage extends StatelessWidget {
  const MealMenuClassesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MealMenuClassesBloc()..add(MealMenuClassesLoaded()),
      child: const _MealMenuClassesContent(),
    );
  }
}

class _MealMenuClassesContent extends StatelessWidget {
  const _MealMenuClassesContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppAppBar(title: 'Meal Menu', actions: [_buildDropdown(context)]),
      body: BlocBuilder<MealMenuClassesBloc, MealMenuClassesState>(
        builder: (context, state) {
          if (state is MealMenuClassesLoading) {
            return const Center(child: AppLoader());
          } else if (state is MealMenuClassesLoadedState) {
            return Column(
              children: [
                _MealMenuCalendar(
                  selectedDate: state.selectedDate,
                  onDateSelected: (date) {
                    context.read<MealMenuClassesBloc>().add(
                      MealMenuClassesDateChanged(date),
                    );
                  },
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: state.classes.length,
                    separatorBuilder: (context, index) =>
                        Divider(height: 1, color: context.colors.surfaceMedium),
                    itemBuilder: (context, index) {
                      final className = state.classes[index];
                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: context.scale(20),
                          vertical: context.scaleHeight(8),
                        ),
                        leading: Container(
                          width: context.scale(24),
                          height: context.scale(24),
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check,
                            size: context.scale(16),
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          className,
                          style: TextStyle(
                            fontSize: context.scaleFont(15),
                            fontWeight: FontWeight.w600,
                            color: context.colors.textPrimary,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: context.scale(16),
                          color: context.colors.textPrimary,
                        ),
                        onTap: () {
                          // TODO: Navigate to details with class and date context
                          context.router.push(const MealMenuDetailsRoute());
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is MealMenuClassesError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildDropdown(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: context.scale(16)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'All',
            style: TextStyle(
              fontSize: context.scaleFont(14),
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const Icon(Icons.arrow_drop_down, color: Colors.white),
        ],
      ),
    );
  }
}

class _MealMenuCalendar extends StatefulWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const _MealMenuCalendar({
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  State<_MealMenuCalendar> createState() => _MealMenuCalendarState();
}

class _MealMenuCalendarState extends State<_MealMenuCalendar> {
  late DateTime _currentViewMonth;

  @override
  void initState() {
    super.initState();
    _currentViewMonth = DateTime(
      widget.selectedDate.year,
      widget.selectedDate.month,
    );
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = _getDaysInMonth();
    final monthName = DateFormat('MMM yyyy').format(_currentViewMonth);

    return Container(
      margin: EdgeInsets.all(context.scale(16)),
      padding: EdgeInsets.all(context.scale(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.scale(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () {
                  setState(() {
                    _currentViewMonth = DateTime(
                      _currentViewMonth.year,
                      _currentViewMonth.month - 1,
                    );
                  });
                },
              ),
              Text(
                monthName,
                style: TextStyle(
                  fontSize: context.scaleFont(18),
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () {
                  setState(() {
                    _currentViewMonth = DateTime(
                      _currentViewMonth.year,
                      _currentViewMonth.month + 1,
                    );
                  });
                },
              ),
            ],
          ),
          SizedBox(height: context.scaleHeight(16)),
          // Weekday Labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'].map((
              day,
            ) {
              return Expanded(
                child: Center(
                  child: Text(
                    day,
                    style: TextStyle(
                      fontSize: context.scaleFont(12),
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: context.scaleHeight(12)),
          // Days Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: daysInMonth.length,
            itemBuilder: (context, index) {
              final date = daysInMonth[index];
              if (date == null) return const SizedBox.shrink();

              final isSelected = _isSameDay(date, widget.selectedDate);
              final isToday = _isSameDay(date, DateTime.now());
              final hasData = true; // For dots as in design

              return GestureDetector(
                onTap: () => widget.onDateSelected(date),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: context.scale(32),
                      width: context.scale(32),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? context.colors.success
                            : Colors.transparent,
                        border: isToday && !isSelected
                            ? Border.all(color: context.colors.primary)
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          '${date.day}',
                          style: TextStyle(
                            fontSize: context.scaleFont(14),
                            color: isSelected ? Colors.white : Colors.black87,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    if (hasData)
                      Container(
                        margin: const EdgeInsets.only(top: 2),
                        height: 4,
                        width: 4,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  List<DateTime?> _getDaysInMonth() {
    final firstDay = DateTime(
      _currentViewMonth.year,
      _currentViewMonth.month,
      1,
    );
    final lastDay = DateTime(
      _currentViewMonth.year,
      _currentViewMonth.month + 1,
      0,
    );

    final days = <DateTime?>[];
    // Adjust for Monday start (Dart weekday: 1=Mon, 7=Sun)
    final firstWeekday = firstDay.weekday;
    for (int i = 1; i < firstWeekday; i++) {
      days.add(null);
    }

    for (int i = 1; i <= lastDay.day; i++) {
      days.add(DateTime(_currentViewMonth.year, _currentViewMonth.month, i));
    }
    return days;
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
