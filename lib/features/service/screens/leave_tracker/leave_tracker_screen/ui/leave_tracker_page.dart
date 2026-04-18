import 'package:auto_route/auto_route.dart';
import 'package:teachers_app/core/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';
import 'package:teachers_app/core/widgets/app_tab_bar.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';
import 'package:teachers_app/features/service/models/leave_models.dart';
import '../bloc/leave_tracker_bloc.dart';
import 'widgets/year_range_picker.dart';
import 'widgets/leave_balance_sheet.dart';

@RoutePage()
class LeaveTrackerPage extends StatelessWidget {
  const LeaveTrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LeaveTrackerBloc()..add(LoadLeaveTracker()),
      child: Scaffold(
        backgroundColor: context.colors.surface100,
        appBar: AppAppBar(
          title: 'Leave Tracker',
          backgroundColor: context.colors.primary,
        ),
        body: Column(
          children: [
            // Tabs
            BlocSelector<LeaveTrackerBloc, LeaveTrackerState, int>(
              selector: (state) =>
                  state is LeaveTrackerLoaded ? state.selectedTabIndex : 0,
              builder: (context, selectedIndex) {
                return AppTabBar(
                  tabs: const ['VIEW', 'HOLIDAY LIST'],
                  selectedIndex: selectedIndex,
                  onTabChanged: (index) {
                    context.read<LeaveTrackerBloc>().add(
                      ChangeTab(index: index),
                    );
                  },
                );
              },
            ),

            // Year Selector
            BlocBuilder<LeaveTrackerBloc, LeaveTrackerState>(
              buildWhen: (prev, curr) =>
                  curr is LeaveTrackerLoaded &&
                  (prev is! LeaveTrackerLoaded ||
                      prev.startDate != curr.startDate ||
                      prev.endDate != curr.endDate),
              builder: (context, state) {
                if (state is LeaveTrackerLoaded) {
                  return YearRangePicker(
                    startDate: state.startDate,
                    endDate: state.endDate,
                    onPrevious: () => context.read<LeaveTrackerBloc>().add(
                      const ChangeYearRange(isNext: false),
                    ),
                    onNext: () => context.read<LeaveTrackerBloc>().add(
                      const ChangeYearRange(isNext: true),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),

            const Divider(height: 1),

            // Content
            Expanded(
              child: BlocBuilder<LeaveTrackerBloc, LeaveTrackerState>(
                builder: (context, state) {
                  if (state is LeaveTrackerLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is LeaveTrackerLoaded) {
                    return state.selectedTabIndex == 0
                        ? _LeaveListView(leaves: state.leaves)
                        : _HolidayListView(holidays: state.holidays);
                  } else if (state is LeaveTrackerError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox();
                },
              ),
            ),

            // Bottom Action
            const _BottomAction(),
          ],
        ),
        floatingActionButton: const _AddLeaveFAB(),
      ),
    );
  }
}

class _LeaveListView extends StatelessWidget {
  final List<LeaveApplication> leaves;
  const _LeaveListView({required this.leaves});

  @override
  Widget build(BuildContext context) {
    if (leaves.isEmpty) {
      return const _EmptyStateView();
    }

    return ListView.builder(
      padding: EdgeInsets.all(context.scale(16)),
      itemCount: leaves.length,
      itemBuilder: (context, index) {
        final leave = leaves[index];
        return _LeaveItemCard(leave: leave);
      },
    );
  }
}

class _LeaveItemCard extends StatelessWidget {
  final LeaveApplication leave;
  const _LeaveItemCard({required this.leave});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy');

    return Card(
      margin: EdgeInsets.only(bottom: context.scaleHeight(12)),
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.scale(12)),
      ),
      child: Padding(
        padding: EdgeInsets.all(context.scale(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  leave.type,
                  style: TextStyle(
                    fontSize: context.scaleFont(15),
                    fontWeight: FontWeight.bold,
                    color: context.colors.textPrimary,
                  ),
                ),
                _StatusBadge(status: leave.status),
              ],
            ),
            SizedBox(height: context.scaleHeight(8)),
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: context.scale(14),
                  color: context.colors.textSecondary,
                ),
                SizedBox(width: context.scale(6)),
                Text(
                  '${dateFormat.format(leave.fromDate)} - ${dateFormat.format(leave.toDate)}',
                  style: TextStyle(
                    fontSize: context.scaleFont(13),
                    color: context.colors.textSecondary,
                  ),
                ),
              ],
            ),
            SizedBox(height: context.scaleHeight(6)),
            Text(
              'Reason: ${leave.reason}',
              style: TextStyle(
                fontSize: context.scaleFont(13),
                color: context.colors.textSecondary,
                fontStyle: FontStyle.italic,
              ),
            ),
            const Divider(),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Applied on ${dateFormat.format(leave.appliedDate)}',
                style: TextStyle(
                  fontSize: context.scaleFont(11),
                  color: context.colors.textTertiary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final LeaveStatus status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;

    switch (status) {
      case LeaveStatus.approved:
        color = context.colors.success;
        label = 'APPROVED';
        break;
      case LeaveStatus.pending:
        color = context.colors.warning;
        label = 'PENDING';
        break;
      case LeaveStatus.rejected:
        color = context.colors.error;
        label = 'REJECTED';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.scale(8),
        vertical: context.scaleHeight(4),
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(context.scale(8)),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: context.scaleFont(10),
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}

class _HolidayListView extends StatelessWidget {
  final List<HolidayModel> holidays;
  const _HolidayListView({required this.holidays});

  @override
  Widget build(BuildContext context) {
    if (holidays.isEmpty) {
      return const _EmptyStateView();
    }

    return ListView.builder(
      padding: EdgeInsets.all(context.scale(16)),
      itemCount: holidays.length,
      itemBuilder: (context, index) {
        final holiday = holidays[index];
        return _HolidayItemCard(holiday: holiday);
      },
    );
  }
}

class _HolidayItemCard extends StatelessWidget {
  final HolidayModel holiday;
  const _HolidayItemCard({required this.holiday});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy, EEEE');

    return Container(
      margin: EdgeInsets.only(bottom: context.scaleHeight(10)),
      padding: EdgeInsets.all(context.scale(12)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.scale(12)),
        border: Border.all(color: context.colors.divider),
      ),
      child: Row(
        children: [
          Container(
            width: context.scale(50),
            height: context.scale(50),
            decoration: BoxDecoration(
              color: context.colors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(context.scale(10)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat('dd').format(holiday.date),
                  style: TextStyle(
                    fontSize: context.scaleFont(18),
                    fontWeight: FontWeight.bold,
                    color: context.colors.primary,
                  ),
                ),
                Text(
                  DateFormat('MMM').format(holiday.date).toUpperCase(),
                  style: TextStyle(
                    fontSize: context.scaleFont(10),
                    fontWeight: FontWeight.bold,
                    color: context.colors.primary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: context.scale(16)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  holiday.title,
                  style: TextStyle(
                    fontSize: context.scaleFont(14),
                    fontWeight: FontWeight.bold,
                    color: context.colors.textPrimary,
                  ),
                ),
                SizedBox(height: context.scaleHeight(4)),
                Text(
                  dateFormat.format(holiday.date),
                  style: TextStyle(
                    fontSize: context.scaleFont(12),
                    color: context.colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.calendar_today,
            size: context.scale(20),
            color: context.colors.primary,
          ),
        ],
      ),
    );
  }
}

class _EmptyStateView extends StatelessWidget {
  const _EmptyStateView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.sentiment_very_dissatisfied,
            size: context.scale(100),
            color: context.colors.surface300,
          ),
          SizedBox(height: context.scaleHeight(20)),
          Text(
            'Trust me, it is empty !',
            style: TextStyle(
              fontSize: context.scaleFont(18),
              fontWeight: FontWeight.bold,
              color: context.colors.primary,
            ),
          ),
          SizedBox(height: context.scaleHeight(8)),
          Text(
            'No Content found. Try after some time',
            style: TextStyle(
              fontSize: context.scaleFont(14),
              color: context.colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomAction extends StatelessWidget {
  const _BottomAction();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.scale(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: InkWell(
          onTap: () {
            final state = context.read<LeaveTrackerBloc>().state;
            if (state is LeaveTrackerLoaded) {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) =>
                    LeaveBalanceSheet(balances: state.balances),
              );
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'VIEW LEAVE BALANCE',
                style: TextStyle(
                  fontSize: context.scaleFont(14),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: context.colors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddLeaveFAB extends StatelessWidget {
  const _AddLeaveFAB();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [context.colors.primary, context.colors.primary2nd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: context.colors.primary.withValues(alpha: 0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: () {
          context.pushRoute(const AddLeaveRoute());
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        highlightElevation: 0,
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }
}
