import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import '../../../core/widgets/app_tab_bar.dart';
import '../../../core/widgets/attendance_calendar.dart';
import 'bloc/birthday_bloc.dart';
import 'models/birthday_member_model.dart';
import 'widgets/birthday_member_card.dart';

@RoutePage()
class BirthdayPage extends StatelessWidget {
  const BirthdayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BirthdayBloc()..add(LoadMonthBirthdays(DateTime.now())),
      child: const _BirthdayPageContent(),
    );
  }
}

class _BirthdayPageContent extends StatefulWidget {
  const _BirthdayPageContent();

  @override
  State<_BirthdayPageContent> createState() => _BirthdayPageContentState();
}

class _BirthdayPageContentState extends State<_BirthdayPageContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppAppBar(title: 'Birthday'),
      body: Column(
        children: [
          // Calendar Section
          Padding(
            padding: EdgeInsets.only(top: context.scaleHeight(16)),
            child: const _CalendarSection(),
          ),

          SizedBox(height: context.scaleHeight(8)),

          // TabBar Section - Using AppTabBar for consistency
          AppTabBar(
            tabs: const ['STUDENTS', 'TEACHERS'],
            selectedIndex: _tabController.index,
            onTabChanged: (index) {
              setState(() {
                _tabController.animateTo(index);
              });
            },
            backgroundColor: Colors.white,
            selectedColor: context.colors.primary,
            unselectedColor: Colors.grey,
            indicatorColor: context.colors.primary,
          ),

          // List Section
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                _BirthdayList(type: BirthdayType.student),
                _BirthdayList(type: BirthdayType.teacher),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CalendarSection extends StatelessWidget {
  const _CalendarSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BirthdayBloc, BirthdayState>(
      buildWhen: (prev, curr) =>
          prev.focusedMonth != curr.focusedMonth ||
          prev.selectedDate != curr.selectedDate ||
          prev.birthdays != curr.birthdays,
      builder: (context, state) {
        return AttendanceCalendar(
          selectedDate: state.selectedDate,
          allowFutureDates: true,
          showLegend: false,
          padding: EdgeInsets.all(context.scale(8)),
          onDateSelected: (date) {
            context.read<BirthdayBloc>().add(SelectBirthdayDate(date));
          },
          onMonthChanged: (month) {
            context.read<BirthdayBloc>().add(ChangeBirthdayMonth(month));
          },
          dayBuilder: (context, date, isSelected, isCurrentMonth) {
            final birthdays = state.getBirthdaysForDay(date);
            final isSunday = date.weekday == 7;

            return Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Selection Highlight
                  if (isSelected)
                    Container(
                      width: context.scale(32),
                      height: context.scale(32),
                      decoration: BoxDecoration(
                        color: context.colors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),

                  // Day number and birthday icon
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
                      // Small birthday indicator (icon)
                      if (birthdays.isNotEmpty && !isSelected)
                        Icon(
                          Icons.cake,
                          size: context.scale(10),
                          color: Colors.pink.shade300,
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

class _BirthdayList extends StatelessWidget {
  final BirthdayType type;

  const _BirthdayList({required this.type});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BirthdayBloc, BirthdayState>(
      buildWhen: (prev, curr) =>
          prev.selectedDate != curr.selectedDate ||
          prev.birthdays != curr.birthdays,
      builder: (context, state) {
        final members = type == BirthdayType.student
            ? state.selectedDateStudentBirthdays
            : state.selectedDateTeacherBirthdays;

        if (members.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cake_outlined,
                  size: context.scale(48),
                  color: Colors.grey.shade300,
                ),
                SizedBox(height: context.scaleHeight(16)),
                Text(
                  'No ${type == BirthdayType.student ? 'students' : 'teachers'} birthdays',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: context.scaleFont(14),
                  ),
                ),
                Text(
                  'for ${DateFormat('EEE, d MMM').format(state.selectedDate)}',
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: context.scaleFont(12),
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: context.scaleHeight(12)),
          itemCount: members.length,
          itemBuilder: (context, index) {
            return BirthdayMemberCard(member: members[index]);
          },
        );
      },
    );
  }
}
