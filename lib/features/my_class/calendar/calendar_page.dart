import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';
import '../../../core/widgets/attendance_calendar.dart';
import 'bloc/calendar_bloc.dart';
import 'widgets/event_list_card.dart';

@RoutePage()
class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CalendarBloc()..add(LoadCalendarEvents(DateTime.now())),
      child: const _CalendarPageContent(),
    );
  }
}

class _CalendarPageContent extends StatelessWidget {
  const _CalendarPageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppAppBar(title: 'Calendar'),
      body: Column(
        children: [
          // Yellow Header
          Expanded(
            child: CustomScrollView(
              slivers: [
                // Calendar Card
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: context.scaleHeight(16)),
                    child: _CalendarSection(),
                  ),
                ),
                // Events for selected date
                const _EventListSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFFFCC00), // Yellow as per screenshot
      padding: EdgeInsets.fromLTRB(
        context.scale(16),
        context.scaleHeight(40),
        context.scale(16),
        context.scaleHeight(16),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => context.router.back(),
          ),
          const Expanded(
            child: Text(
              'Event List',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 48), // Spacer to balance back button
        ],
      ),
    );
  }
}

class _CalendarSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      buildWhen: (prev, curr) =>
          prev.focusedMonth != curr.focusedMonth ||
          prev.selectedDate != curr.selectedDate ||
          prev.events != curr.events,
      builder: (context, state) {
        return AttendanceCalendar(
          selectedDate: state.selectedDate,
          allowFutureDates: true,
          showLegend: false,
          padding: EdgeInsets.all(context.scale(8)),
          onDateSelected: (date) {
            context.read<CalendarBloc>().add(SelectCalendarDate(date));
          },
          onMonthChanged: (month) {
            context.read<CalendarBloc>().add(ChangeCalendarMonth(month));
          },
          dayBuilder: (context, date, isSelected, isCurrentMonth) {
            final events = state.getEventsForDay(date);
            final isSunday = date.weekday == 7;

            // Check for special highlights (large red/green circles)
            final specialHighlight = events
                .where((e) => e.isSpecialHighlight)
                .firstOrNull;

            return Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Selection or Special Highlight Background
                  if (isSelected)
                    Container(
                      width: context.scale(32),
                      height: context.scale(32),
                      decoration: BoxDecoration(
                        color: context.colors.primary,
                        shape: BoxShape.circle,
                      ),
                    )
                  else if (specialHighlight != null)
                    Container(
                      width: context.scale(36),
                      height: context.scale(36),
                      decoration: BoxDecoration(
                        color: specialHighlight.typeColor.withValues(
                          alpha: 0.2,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),

                  // Day number
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        date.day.toString(),
                        style: TextStyle(
                          fontSize: context.scaleFont(14),
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: !isCurrentMonth
                              ? Colors.grey.withValues(alpha: 0.3)
                              : isSelected
                              ? Colors.white
                              : isSunday
                              ? const Color(0xFFF44336)
                              : Colors.grey.shade800,
                        ),
                      ),
                      // Dots below day
                      if (events.isNotEmpty && !isSelected)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: events.take(3).map((e) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 1),
                              width: 3,
                              height: 3,
                              decoration: BoxDecoration(
                                color: e.typeColor,
                                shape: BoxShape.circle,
                              ),
                            );
                          }).toList(),
                        ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _EventListSection extends StatelessWidget {
  const _EventListSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      buildWhen: (prev, curr) =>
          prev.selectedDate != curr.selectedDate || prev.events != curr.events,
      builder: (context, state) {
        final events = state.selectedDateEvents;

        if (events.isEmpty) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: context.scaleHeight(40)),
              child: Center(
                child: Text(
                  'No events for ${DateFormat('EEE, d MMM').format(state.selectedDate)}',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: context.scaleFont(14),
                  ),
                ),
              ),
            ),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return EventListCard(event: events[index]);
          }, childCount: events.length),
        );
      },
    );
  }
}
