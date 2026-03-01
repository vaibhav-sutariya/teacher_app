import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';
import '../models/dashboard_models.dart';
import 'dashboard_card.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

class HomeworkCard extends StatelessWidget {
  const HomeworkCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, HomeworkStatsModel>(
      selector: (state) => state.homeworkStats,
      builder: (context, stats) {
        return DashboardCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.assignment_outlined,
                    color: context.colors.error,
                    size: context.scale(28),
                  ),
                  Expanded(
                    child: Text(
                      "Today's Homework",
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
                'Updated in Section(s) ${stats.updatedSections}/${stats.totalSections}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: context.scaleFont(14),
                  color: context.colors.textPrimary,
                ),
              ),
              Divider(
                height: context.scaleHeight(24),
                color: context.colors.divider,
              ),
              Text(
                stats.date != null
                    ? DateFormat('dd/MMM/yyyy EEEE').format(stats.date!)
                    : '-',
                style: TextStyle(
                  fontSize: context.scaleFont(12),
                  color: context.colors.textTertiary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
