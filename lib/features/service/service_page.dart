import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';
import 'package:teachers_app/core/widgets/end_of_list_indicator.dart';
import 'package:teachers_app/core/widgets/month_calendar.dart';

import 'bloc/service_bloc.dart';
import 'widgets/service_card.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

@RoutePage()
class ServicePage extends StatelessWidget {
  const ServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServiceBloc()..add(LoadServiceData()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: const AppAppBar(title: 'Notice Board', showBackButton: false),
        body: Column(
          children: [
            /// Month Calendar - Rebuilds only when selectedMonth changes
            BlocSelector<ServiceBloc, ServiceState, DateTime>(
              selector: (state) {
                if (state is ServiceLoadedState) {
                  return state.selectedMonth;
                }
                return DateTime(DateTime.now().year, DateTime.now().month, 1);
              },
              builder: (context, selectedMonth) {
                return MonthCalendar(
                  selectedMonth: selectedMonth,
                  onMonthChanged: (month) {
                    context.read<ServiceBloc>().add(ServiceMonthChanged(month));
                  },
                );
              },
            ),

            /// Notice List - Rebuilds when notices or loading status changes
            Expanded(
              child: BlocBuilder<ServiceBloc, ServiceState>(
                builder: (context, state) {
                  if (state is ServiceLoadedState) {
                    if (state.isLoading && state.noticeList.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.noticeList.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.notifications_off_outlined,
                              size: context.scale(60),
                              color: context.colors.border,
                            ),
                            SizedBox(height: context.scaleHeight(16)),
                            Text(
                              'No notices for this month',
                              style: TextStyle(
                                fontSize: context.scaleFont(16),
                                color: context.colors.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<ServiceBloc>().add(RefreshServiceData());
                      },
                      child: ListView.builder(
                        itemCount: state.noticeList.length + 1,
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.only(
                          bottom: context.scaleHeight(80),
                        ),
                        itemBuilder: (context, index) {
                          if (index == state.noticeList.length) {
                            return const EndOfListIndicator();
                          }
                          return ServiceCard(notice: state.noticeList[index]);
                        },
                      ),
                    );
                  }

                  if (state is ServiceError) {
                    return Center(child: Text(state.message));
                  }

                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
