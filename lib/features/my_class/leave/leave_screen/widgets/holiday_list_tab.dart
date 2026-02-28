import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../core/widgets/app_loader.dart';
import '../../../../../core/widgets/end_of_list_indicator.dart';
import '../bloc/leave_bloc.dart';
import '../models/holiday_model.dart';

/// HOLIDAY LIST tab content - displays school holidays
class HolidayListTab extends StatelessWidget {
  const HolidayListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LeaveBloc, LeaveState, LeaveState>(
      selector: (state) => state,
      builder: (context, state) {
        if (state is LeaveLoading) {
          return const AppLoader();
        } else if (state is LeaveLoadedState) {
          if (state.isLoading) {
            return const AppLoader();
          }
          if (state.holidayList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.event_available_outlined,
                    size: context.scale(64),
                    color: Colors.grey.withValues(alpha: 0.5),
                  ),
                  SizedBox(height: context.scaleHeight(16)),
                  Text(
                    'No Holidays',
                    style: TextStyle(
                      fontSize: context.scaleFont(16),
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(context.scale(16)),
            itemCount: state.holidayList.length + 1,
            itemBuilder: (context, index) {
              if (index == state.holidayList.length) {
                return const EndOfListIndicator();
              }
              return Padding(
                padding: EdgeInsets.only(bottom: context.scaleHeight(12)),
                child: _buildHolidayCard(
                  context,
                  holiday: state.holidayList[index],
                ),
              );
            },
          );
        } else if (state is LeaveError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildHolidayCard(
    BuildContext context, {
    required HolidayModel holiday,
  }) {
    return RepaintBoundary(
      child: Container(
        padding: EdgeInsets.all(context.scale(16)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(context.scale(12)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Date container
            Container(
              width: context.scale(60),
              height: context.scale(60),
              decoration: BoxDecoration(
                color: Color(holiday.typeColor).withOpacity(0.1),
                borderRadius: BorderRadius.circular(context.scale(12)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    holiday.date.day.toString(),
                    style: TextStyle(
                      fontSize: context.scaleFont(24),
                      fontWeight: FontWeight.bold,
                      color: Color(holiday.typeColor),
                    ),
                  ),
                  Text(
                    _getMonthName(holiday.date.month),
                    style: TextStyle(
                      fontSize: context.scaleFont(12),
                      color: Color(holiday.typeColor),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: context.scale(16)),
            // Holiday info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    holiday.name,
                    style: TextStyle(
                      fontSize: context.scaleFont(14),
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(4)),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.scale(8),
                      vertical: context.scaleHeight(4),
                    ),
                    decoration: BoxDecoration(
                      color: Color(holiday.typeColor).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(context.scale(4)),
                    ),
                    child: Text(
                      holiday.typeText,
                      style: TextStyle(
                        fontSize: context.scaleFont(11),
                        fontWeight: FontWeight.w600,
                        color: Color(holiday.typeColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}
