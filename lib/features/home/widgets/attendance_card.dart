import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';
import '../models/dashboard_models.dart';
import 'dashboard_card.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

class AttendanceCard extends StatelessWidget {
  const AttendanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, AttendanceStatsModel>(
      selector: (state) => state.attendanceStats,
      builder: (context, stats) {
        return DashboardCard(
          padding: EdgeInsets.symmetric(
            horizontal: context.scale(16),
            vertical: context.scaleHeight(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.assignment_turned_in_outlined,
                    color: context.colors.success,
                    size: context.scale(28),
                  ),
                  Expanded(
                    child: Text(
                      "Today's Attendance",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: context.scaleFont(16),
                        fontWeight: FontWeight.w600,
                        color: context.colors.textSecondary,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: context.colors.warning,
                    size: context.scale(16),
                  ),
                ],
              ),
              Divider(
                height: context.scaleHeight(24),
                color: context.colors.divider,
              ),

              Text(
                'Marked in Section(s) ${stats.markedSections}/${stats.totalSections}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: context.scaleFont(14),
                  color: context.colors.textPrimary,
                ),
              ),
              Divider(
                height: context.scaleHeight(24),
                color: context.colors.border,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _StatColumn(
                    'Total',
                    stats.totalStudents.toString(),
                    context.colors.textPrimary,
                  ),
                  _StatColumn('Marked', stats.markedStudents, Colors.blue),
                  _StatColumn(
                    'P',
                    stats.present.toString(),
                    context.colors.success,
                  ),
                  _StatColumn(
                    'A',
                    stats.absent.toString(),
                    context.colors.error,
                  ),
                  _StatColumn(
                    'L',
                    stats.leave.toString(),
                    context.colors.warning,
                  ),
                  _StatColumn('%', stats.percentage.toString(), Colors.blue),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const _StatColumn(this.label, this.value, this.valueColor);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: context.scaleFont(12),
            color: context.colors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: context.scaleHeight(8)),
        Text(
          value,
          style: TextStyle(
            fontSize: context.scaleFont(14),
            color: valueColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
