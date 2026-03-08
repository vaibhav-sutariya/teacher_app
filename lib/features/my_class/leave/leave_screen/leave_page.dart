import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/routes/app_router.gr.dart';

import '../../../../core/widgets/app_app_bar.dart';
import '../../../../core/widgets/app_tab_bar.dart';
import '../../../../core/widgets/month_calendar.dart';
import '../../../../cubit/theme_cubit.dart';
import 'bloc/leave_bloc.dart';
import 'widgets/holiday_list_tab.dart';
import 'widgets/view_tab.dart';

/// My Leave page with tabbed interface
/// Features:
/// - VIEW tab: Leave applications and balance
/// - HOLIDAY LIST tab: School holiday calendar
/// - Month-wise filtering with calendar widget
/// - High performance with minimal rebuilds
/// - Production-ready code
@RoutePage()
class LeavePage extends StatelessWidget {
  const LeavePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LeaveBloc()..add(LoadLeaveData()),
      child: Scaffold(
        backgroundColor: context.colors.surface100,
        appBar: const AppAppBar(title: 'My Leave'),
        body: Column(
          children: [
            // Tab Bar - only rebuilds when selected index changes
            BlocSelector<LeaveBloc, LeaveState, int>(
              selector: (state) {
                if (state is LeaveLoadedState) return state.selectedTabIndex;
                return 0; // Default to first tab
              },
              builder: (context, selectedIndex) {
                return AppTabBar(
                  tabs: const ['VIEW', 'HOLIDAY LIST'],
                  selectedIndex: selectedIndex,
                  onTabChanged: (index) {
                    context.read<LeaveBloc>().add(ChangeTabEvent(index));
                  },
                );
              },
            ),

            // Month Calendar - only rebuilds when selected month changes
            BlocSelector<LeaveBloc, LeaveState, DateTime?>(
              selector: (state) {
                if (state is LeaveLoadedState) return state.selectedMonth;
                return null;
              },
              builder: (context, selectedMonth) {
                if (selectedMonth == null) {
                  return const SizedBox.shrink();
                }
                return MonthCalendar(
                  selectedMonth: selectedMonth,
                  onMonthChanged: (month) {
                    context.read<LeaveBloc>().add(MonthChanged(month));
                  },
                );
              },
            ),

            // Tab Content - IndexedStack keeps both tabs alive
            Expanded(
              child: BlocSelector<LeaveBloc, LeaveState, int>(
                selector: (state) {
                  if (state is LeaveLoadedState) return state.selectedTabIndex;
                  return 0; // Default to first tab
                },
                builder: (context, selectedIndex) {
                  return IndexedStack(
                    index: selectedIndex,
                    children: const [ViewTab(), HolidayListTab()],
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.router.push(AddLeaveRoute());
          },
          backgroundColor: context.colors.primary,
          foregroundColor: Colors.white,
          elevation: 4,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
