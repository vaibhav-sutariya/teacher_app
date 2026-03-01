import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';
import '../models/dashboard_models.dart';
import 'dashboard_card.dart';

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
                    color: Colors.redAccent.shade200,
                    size: context.scale(28),
                  ),
                  Expanded(
                    child: Text(
                      "Today's Homework",
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
                'Updated in Section(s) ${stats.updatedSections}/${stats.totalSections}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: context.scaleFont(14),
                  color: Colors.black87,
                ),
              ),
              Divider(
                height: context.scaleHeight(24),
                color: Colors.grey.shade200,
              ),
              Text(
                stats.date != null
                    ? DateFormat('dd/MMM/yyyy EEEE').format(stats.date!)
                    : '-',
                style: TextStyle(
                  fontSize: context.scaleFont(12),
                  color: Colors.grey.shade400,
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
