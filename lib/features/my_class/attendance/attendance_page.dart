import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../core/routes/app_router.gr.dart';
import '../../../core/widgets/app_app_bar.dart';
import '../../../core/widgets/app_date_picker.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../core/widgets/app_tab_bar.dart';
import '../../../core/widgets/error_state.dart';
import '../../../cubit/theme_cubit.dart';
import 'bloc/attendance_bloc.dart';
import 'bloc/attendance_event.dart';
import 'bloc/attendance_state.dart';
import 'widgets/class_section_card.dart';

@RoutePage()
class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AttendanceBloc(),
      child: const _AttendancePageContent(),
    );
  }
}

class _AttendancePageContent extends StatelessWidget {
  const _AttendancePageContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceBloc, AttendanceState>(
      // Only rebuild whole page if critical state elements change
      // (avoid rebuilding on minor calendar internal updates)
      buildWhen: (previous, current) =>
          previous.isLoading != current.isLoading ||
          previous.errorMessage != current.errorMessage ||
          previous.selectedTabIndex != current.selectedTabIndex ||
          previous.selectedDate != current.selectedDate,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF8F9FB), // Light grey background
          appBar: AppAppBar(title: 'Attendance'),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Tab Bar
              AppTabBar(
                tabs: const ['PENDING', 'MARKED'],
                selectedIndex: state.selectedTabIndex,
                onTabChanged: (index) {
                  context.read<AttendanceBloc>().add(ChangeTabEvent(index));
                },
              ),

              // 2. Date Picker
              AppInlineDatePicker(
                selectedDate: state.selectedDate,
                onDateSelected: (date) {
                  context.read<AttendanceBloc>().add(SelectDateEvent(date));
                },
              ),

              // 3. Selection Title
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.scale(16),
                  vertical: context.scaleHeight(16),
                ),
                child: Text(
                  'SELECT CLASS SECTION',
                  style: TextStyle(
                    fontSize: context.scaleFont(14),
                    fontWeight: FontWeight.bold,
                    color: context.colors.primary,
                    letterSpacing: 1.2,
                  ),
                ),
              ),

              // 4. Loading/Error/List States
              Expanded(child: _buildListContent(context, state)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildListContent(BuildContext context, AttendanceState state) {
    if (state.isLoading) {
      return const Center(child: AppLoader());
    }

    if (state.errorMessage != null) {
      return ErrorState(
        message: state.errorMessage!,
        onRetry: () =>
            context.read<AttendanceBloc>().add(const RefreshAttendanceEvent()),
      );
    }

    final isPendingTab = state.selectedTabIndex == 0;
    final displayClasses = isPendingTab
        ? state.pendingClasses
        : state.markedClasses;

    return CustomScrollView(
      slivers: [
        if (displayClasses.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Text(
                isPendingTab ? 'No pending classes' : 'No marked classes',
                style: TextStyle(
                  color: context.colors.textSecondary,
                  fontSize: context.scaleFont(16),
                ),
              ),
            ),
          )
        else
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final section = displayClasses[index];
              return ClassSectionCard(
                section: section,
                onTap: () {
                  context.router.push(
                    AttendanceEntryRoute(
                      className: section.sectionName,
                      date: state.selectedDate,
                    ),
                  );
                },
              );
            }, childCount: displayClasses.length),
          ),

        // Info card below pending items
        if (isPendingTab && displayClasses.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(context.scale(16)),
              child: Container(
                padding: EdgeInsets.all(context.scale(16)),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F2EF),
                  borderRadius: BorderRadius.circular(context.scale(12)),
                  border: Border.all(
                    color: context.colors.primary.withValues(alpha: 0.1),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info,
                      color: context.colors.primary,
                      size: context.scale(20),
                    ),
                    SizedBox(width: context.scale(12)),
                    Expanded(
                      child: Text(
                        'Attendance for the remaining ${displayClasses.length} sections is still pending for today. Please ensure all markings are completed before the end of school hours.',
                        style: TextStyle(
                          color: context.colors.primary,
                          fontSize: context.scaleFont(14),
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
