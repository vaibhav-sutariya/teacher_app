import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../../../core/routes/app_router.gr.dart';
import '../../../../models/concern_model.dart';
import '../../../../bloc/concern_bloc.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

class ConcernItem extends StatelessWidget {
  final ConcernModel concern;

  const ConcernItem({super.key, required this.concern});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await context.router.push(
          ConcernDetailsRoute(concern: concern),
        );
        if (result == true && context.mounted) {
          context.read<ConcernBloc>().add(LoadConcerns());
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: context.scale(16)),
        padding: EdgeInsets.all(context.scale(16)),
        decoration: BoxDecoration(
          color: context.colors.textInverse,
          borderRadius: BorderRadius.circular(context.scale(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStudentInfo(context),
                _buildStatusBadge(context),
              ],
            ),
            SizedBox(height: context.scaleHeight(16)),
            Text(
              concern.title,
              style: TextStyle(
                fontSize: context.scaleFont(16),
                fontWeight: FontWeight.bold,
                color: context.colors.textPrimary,
              ),
            ),
            SizedBox(height: context.scaleHeight(8)),
            Row(
              children: [
                Text(
                  concern.ticketNumber,
                  style: TextStyle(
                    fontSize: context.scaleFont(12),
                    fontWeight: FontWeight.w600,
                    color: context.colors.secondary,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(width: context.scale(12)),
                Icon(
                  _getDepartmentIcon(concern.department),
                  size: context.scale(14),
                  color: context.colors.textSecondary,
                ),
                SizedBox(width: context.scale(4)),
                Text(
                  concern.department,
                  style: TextStyle(
                    fontSize: context.scaleFont(12),
                    color: context.colors.textSecondary,
                  ),
                ),
              ],
            ),
            SizedBox(height: context.scaleHeight(16)),
            Divider(color: Colors.grey.withValues(alpha: 0.1), height: 1),
            SizedBox(height: context.scaleHeight(12)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: context.scale(14),
                      color: context.colors.textSecondary,
                    ),
                    SizedBox(width: context.scale(6)),
                    Text(
                      _formatDate(concern.date),
                      style: TextStyle(
                        fontSize: context.scaleFont(12),
                        color: context.colors.textSecondary,
                      ),
                    ),
                  ],
                ),
                Text(
                  'View Details',
                  style: TextStyle(
                    fontSize: context.scaleFont(12),
                    fontWeight: FontWeight.w600,
                    color: context.colors.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentInfo(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: context.scale(18),
          backgroundImage: concern.studentAvatar != null
              ? NetworkImage(concern.studentAvatar!)
              : null,
          child: concern.studentAvatar == null
              ? Icon(Icons.person, size: context.scale(20))
              : null,
        ),
        SizedBox(width: context.scale(10)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              concern.studentName,
              style: TextStyle(
                fontSize: context.scaleFont(14),
                fontWeight: FontWeight.w600,
                color: context.colors.textPrimary,
              ),
            ),
            Text(
              concern.studentGrade,
              style: TextStyle(
                fontSize: context.scaleFont(12),
                color: context.colors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.scale(12),
        vertical: context.scale(4),
      ),
      decoration: BoxDecoration(
        color: concern.statusColor,
        borderRadius: BorderRadius.circular(context.scale(12)),
      ),
      child: Text(
        concern.statusLabel,
        style: TextStyle(
          fontSize: context.scaleFont(10),
          fontWeight: FontWeight.bold,
          color: concern.statusTextColor,
        ),
      ),
    );
  }

  IconData _getDepartmentIcon(String department) {
    switch (department.toLowerCase()) {
      case 'academic affairs':
        return Icons.school_outlined;
      case 'facilities':
        return Icons.wifi_tethering;
      case 'finance':
        return Icons.payments_outlined;
      case 'administration':
        return Icons.admin_panel_settings_outlined;
      default:
        return Icons.business_outlined;
    }
  }

  String _formatDate(DateTime date) {
    final months = [
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
    final month = months[date.month - 1];
    final hour = date.hour > 12
        ? date.hour - 12
        : date.hour == 0
        ? 12
        : date.hour;
    final period = date.hour >= 12 ? 'PM' : 'AM';
    final minute = date.minute.toString().padLeft(2, '0');

    return '$month ${date.day}, $hour:$minute $period';
  }
}
