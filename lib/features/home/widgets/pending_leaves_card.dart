import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';
import '../models/dashboard_models.dart';
import 'dashboard_card.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

class PendingLeavesCard extends StatelessWidget {
  const PendingLeavesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, List<LeaveModel>>(
      selector: (state) => state.pendingLeaves,
      builder: (context, leaves) {
        return DashboardCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DashboardSectionTitle(
                icon: Icons.business_center_outlined,
                iconColor: Color(0xFF0288D1), // Blue
                title: 'Student Pending Leave Approvals',
              ),
              SizedBox(height: context.scaleHeight(16)),
              if (leaves.isEmpty)
                Padding(
                  padding: EdgeInsets.all(context.scale(16)),
                  child: const Center(child: Text("No pending leaves")),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: leaves.length,
                  itemBuilder: (context, index) {
                    final leave = leaves[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: context.scaleHeight(8),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: context.scale(20),
                            backgroundImage: NetworkImage(
                              'https://i.pravatar.cc/150?img=${10 + index}',
                            ),
                          ),
                          SizedBox(width: context.scale(12)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${leave.leaveType} | ${leave.studentName}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: context.scaleFont(13),
                                    color: context.colors.textPrimary,
                                  ),
                                ),
                                Text(
                                  leave.gradeSection,
                                  style: TextStyle(
                                    fontSize: context.scaleFont(11),
                                    color: context.colors.textSecondary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              SizedBox(height: context.scaleHeight(16)),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'View more...',
                  style: TextStyle(
                    color: context.colors.error,
                    fontWeight: FontWeight.bold,
                    fontSize: context.scaleFont(12),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
