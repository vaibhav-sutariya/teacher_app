import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';
import '../models/dashboard_models.dart';
import 'dashboard_card.dart';

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
                    color: Colors.green.shade800,
                    size: context.scale(28),
                  ),
                  Expanded(
                    child: Text(
                      "Today's Attendance",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: context.scaleFont(16),
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.amber.shade600,
                    size: context.scale(16),
                  ),
                ],
              ),
              Divider(
                height: context.scaleHeight(24),
                color: Colors.grey.shade200,
              ),

              Text(
                'Marked in Section(s) ${stats.markedSections}/${stats.totalSections}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: context.scaleFont(14),
                  color: Colors.black87,
                ),
              ),
              Divider(
                height: context.scaleHeight(24),
                color: Colors.grey.shade300,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _StatColumn(
                    'Total',
                    stats.totalStudents.toString(),
                    Colors.black87,
                  ),
                  _StatColumn('Marked', stats.markedStudents, Colors.blue),
                  _StatColumn('P', stats.present.toString(), Colors.green),
                  _StatColumn('A', stats.absent.toString(), Colors.red),
                  _StatColumn(
                    'L',
                    stats.leave.toString(),
                    Colors.amber.shade600,
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
            color: Colors.grey.shade600,
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
