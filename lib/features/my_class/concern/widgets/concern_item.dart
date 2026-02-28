import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../core/routes/app_router.gr.dart';
import '../models/concern_model.dart';

class ConcernItem extends StatelessWidget {
  final ConcernModel concern;

  const ConcernItem({super.key, required this.concern});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(ConcernDetailsRoute(concern: concern));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: context.scale(16)),
        padding: EdgeInsets.all(context.scale(16)),
        decoration: BoxDecoration(
          color: Colors.white,
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
                Text(
                  concern.ticketNumber,
                  style: TextStyle(
                    fontSize: context.scaleFont(12),
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF5C6BC0), // Indigo based color
                    letterSpacing: 0.5,
                  ),
                ),
                _buildStatusBadge(context),
              ],
            ),
            SizedBox(height: context.scaleHeight(8)),
            Text(
              concern.title,
              style: TextStyle(
                fontSize: context.scaleFont(16),
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: context.scaleHeight(8)),
            Row(
              children: [
                Icon(
                  _getDepartmentIcon(concern.department),
                  size: context.scale(16),
                  color: const Color(0xFF5C6BC0),
                ),
                SizedBox(width: context.scale(6)),
                Text(
                  concern.department,
                  style: TextStyle(
                    fontSize: context.scaleFont(14),
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF5C6BC0),
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
                      color: Colors.grey[500],
                    ),
                    SizedBox(width: context.scale(6)),
                    Text(
                      _formatDate(concern.date),
                      style: TextStyle(
                        fontSize: context.scaleFont(12),
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: context.scale(14),
                  color: Colors.blue[300],
                ),
              ],
            ),
          ],
        ),
      ),
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
    // Simple formatting, could use intl package if available
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
