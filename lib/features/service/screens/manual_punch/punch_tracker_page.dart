import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';
import 'package:teachers_app/core/widgets/app_tab_bar.dart';
import 'package:teachers_app/core/widgets/empty_state_view.dart';
import 'package:teachers_app/core/widgets/month_calendar.dart';
import 'package:teachers_app/core/routes/app_router.gr.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import '../../models/punch_models.dart';
import 'bloc/punch_tracker_bloc.dart';

@RoutePage()
class PunchTrackerPage extends StatelessWidget {
  const PunchTrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PunchTrackerBloc()..add(LoadPunchData(DateTime.now())),
      child: Scaffold(
        backgroundColor: context.colors.surface100,
        appBar: const AppAppBar(title: 'Punch Tracker'),
        body: Column(
          children: [
            // Tabs
            BlocSelector<PunchTrackerBloc, PunchTrackerState, int>(
              selector: (state) {
                if (state is PunchTrackerLoaded) {
                  return state.selectedTabIndex;
                }
                return 0;
              },
              builder: (context, selectedIndex) {
                return AppTabBar(
                  tabs: const ['VIEW', 'HOLIDAY LIST'],
                  selectedIndex: selectedIndex,
                  onTabChanged: (index) {
                    context.read<PunchTrackerBloc>().add(ChangePunchTab(index));
                  },
                );
              },
            ),

            // Month Picker (Only for VIEW tab)
            BlocSelector<
              PunchTrackerBloc,
              PunchTrackerState,
              Map<String, dynamic>
            >(
              selector: (state) {
                if (state is PunchTrackerLoaded) {
                  return {
                    'month': state.selectedMonth,
                    'isViewTab': state.selectedTabIndex == 0,
                  };
                }
                return {'month': DateTime.now(), 'isViewTab': true};
              },
              builder: (context, data) {
                if (!(data['isViewTab'] as bool)) return const SizedBox();
                return MonthCalendar(
                  selectedMonth: data['month'] as DateTime,
                  onMonthChanged: (newMonth) {
                    context.read<PunchTrackerBloc>().add(
                      LoadPunchData(newMonth),
                    );
                  },
                );
              },
            ),

            // Tab Content
            Expanded(
              child: BlocBuilder<PunchTrackerBloc, PunchTrackerState>(
                builder: (context, state) {
                  if (state is PunchTrackerLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: context.colors.primary,
                      ),
                    );
                  } else if (state is PunchTrackerLoaded) {
                    if (state.selectedTabIndex == 1) {
                      // Holiday List Tab
                      return const EmptyStateView(
                        title: 'No Holidays Found',
                        subtitle: 'Enjoy your working days!',
                        icon: Icons.celebration_outlined,
                      );
                    }

                    if (state.records.isEmpty) {
                      return const EmptyStateView();
                    }

                    return ListView.builder(
                      padding: EdgeInsets.all(context.scale(16)),
                      itemCount: state.records.length,
                      itemBuilder: (context, index) {
                        final record = state.records[index];
                        return _PunchRecordCard(record: record);
                      },
                    );
                  } else if (state is PunchTrackerError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
        floatingActionButton: BlocBuilder<PunchTrackerBloc, PunchTrackerState>(
          builder: (context, state) {
            if (state is PunchTrackerLoaded && state.selectedTabIndex == 0) {
              return FloatingActionButton(
                onPressed: () {
                  context.pushRoute(const AddManualPunchRoute());
                },
                backgroundColor: context.colors.primary,
                child: const Icon(Icons.add, color: Colors.white),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class _PunchRecordCard extends StatelessWidget {
  final PunchRecord record;
  const _PunchRecordCard({required this.record});

  @override
  Widget build(BuildContext context) {
    final isPunchIn = record.type == PunchType.inPunch;

    return Container(
      margin: EdgeInsets.only(bottom: context.scaleHeight(12)),
      padding: EdgeInsets.all(context.scale(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.scale(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(context.scale(10)),
            decoration: BoxDecoration(
              color: (isPunchIn ? Colors.blue : Colors.orange).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isPunchIn ? Icons.login_outlined : Icons.logout_outlined,
              color: isPunchIn ? Colors.blue : Colors.orange,
              size: context.scale(20),
            ),
          ),
          SizedBox(width: context.scale(16)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isPunchIn ? 'In Punch' : 'Out Punch',
                  style: TextStyle(
                    fontSize: context.scaleFont(16),
                    fontWeight: FontWeight.bold,
                    color: context.colors.textPrimary,
                  ),
                ),
                if (record.reason != null) ...[
                  SizedBox(height: context.scaleHeight(4)),
                  Text(
                    record.reason!,
                    style: TextStyle(
                      fontSize: context.scaleFont(13),
                      color: context.colors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                record.time,
                style: TextStyle(
                  fontSize: context.scaleFont(14),
                  fontWeight: FontWeight.bold,
                  color: context.colors.textPrimary,
                ),
              ),
              SizedBox(height: context.scaleHeight(4)),
              Text(
                record.date,
                style: TextStyle(
                  fontSize: context.scaleFont(12),
                  color: context.colors.textTertiary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
