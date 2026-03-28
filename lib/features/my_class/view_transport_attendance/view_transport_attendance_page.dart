import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../core/widgets/app_app_bar.dart';
import '../../../../core/widgets/app_date_picker.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/widgets/app_tab_bar.dart';
import '../../../../core/widgets/error_state.dart';
import '../../../../cubit/theme_cubit.dart';
import '../../../core/routes/app_router.gr.dart';
import 'bloc/view_transport_attendance_bloc.dart';
import 'widgets/view_transport_attendance_card.dart';

@RoutePage()
class ViewTransportAttendancePage extends StatelessWidget {
  const ViewTransportAttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ViewTransportAttendanceBloc()..add(LoadRoutesForDateEvent()),
      child: const _ViewTransportAttendanceContent(),
    );
  }
}

class _ViewTransportAttendanceContent extends StatelessWidget {
  const _ViewTransportAttendanceContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface100,
      appBar: const AppAppBar(title: 'View Transport Attendance'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Tab Bar
          BlocSelector<
            ViewTransportAttendanceBloc,
            ViewTransportAttendanceState,
            int
          >(
            selector: (state) => state.selectedTabIndex,
            builder: (context, selectedIndex) {
              return AppTabBar(
                tabs: const ['PENDING', 'MARKED'],
                selectedIndex: selectedIndex,
                onTabChanged: (index) {
                  context.read<ViewTransportAttendanceBloc>().add(
                    ChangeTabEvent(index),
                  );
                },
              );
            },
          ),

          // 2. Date Picker
          BlocSelector<
            ViewTransportAttendanceBloc,
            ViewTransportAttendanceState,
            DateTime
          >(
            selector: (state) => state.selectedDate,
            builder: (context, selectedDate) {
              return AppInlineDatePicker(
                selectedDate: selectedDate,
                onDateSelected: (date) {
                  context.read<ViewTransportAttendanceBloc>().add(
                    SelectDateEvent(date),
                  );
                },
              );
            },
          ),

          // 3. Selection Title
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.scale(16),
              vertical: context.scaleHeight(16),
            ),
            child: Text(
              'SELECT TRANSPORT ROUTE',
              style: TextStyle(
                fontSize: context.scaleFont(14),
                fontWeight: FontWeight.bold,
                color: context.colors.primary,
                letterSpacing: 1.2,
              ),
            ),
          ),

          // 4. Loading/Error/List States
          Expanded(
            child:
                BlocBuilder<
                  ViewTransportAttendanceBloc,
                  ViewTransportAttendanceState
                >(
                  buildWhen: (previous, current) =>
                      previous.isLoading != current.isLoading ||
                      previous.errorMessage != current.errorMessage ||
                      previous.pendingRoutes != current.pendingRoutes ||
                      previous.markedRoutes != current.markedRoutes ||
                      previous.selectedTabIndex != current.selectedTabIndex,
                  builder: (context, state) =>
                      _buildListContent(context, state),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildListContent(
    BuildContext context,
    ViewTransportAttendanceState state,
  ) {
    if (state.isLoading) {
      return const Center(child: AppLoader());
    }

    if (state.errorMessage != null) {
      return ErrorState(
        message: state.errorMessage!,
        onRetry: () => context.read<ViewTransportAttendanceBloc>().add(
          LoadRoutesForDateEvent(),
        ),
      );
    }

    final isPendingTab = state.selectedTabIndex == 0;
    final displayRoutes = isPendingTab
        ? state.pendingRoutes
        : state.markedRoutes;

    return CustomScrollView(
      slivers: [
        if (displayRoutes.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Text(
                isPendingTab ? 'No pending routes' : 'No marked routes',
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
              final route = displayRoutes[index];
              return ViewTransportAttendanceCard(
                route: route,
                onTap: () {
                  context.router.push(
                    ViewTransportAttendanceDetailRoute(
                      routeModel: route,
                      date: state.selectedDate,
                    ),
                  );
                },
              );
            }, childCount: displayRoutes.length),
          ),

        // Info card below pending items
        if (isPendingTab && displayRoutes.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(context.scale(16)),
              child: Container(
                padding: EdgeInsets.all(context.scale(16)),
                decoration: BoxDecoration(
                  color: context.colors.successLight,
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
                        'Attendance for the remaining ${displayRoutes.length} transport routes is still pending for today. Please ensure all markings are completed before the end of the day.',
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
