import 'package:flutter/material.dart';

import '../../../../../core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

/// Reusable leave status badge widget
/// Shows approval status with colored background
class LeaveStatusBadge extends StatelessWidget {
  final String status;
  final String? approvedBy;

  const LeaveStatusBadge({super.key, required this.status, this.approvedBy});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.scale(12),
        vertical: context.scaleHeight(6),
      ),
      decoration: BoxDecoration(
        color: _getBackgroundColor(context),
        borderRadius: BorderRadius.circular(context.scale(4)),
      ),
      child: Text(
        _getStatusText(),
        style: TextStyle(
          fontSize: context.scaleFont(11),
          fontWeight: FontWeight.bold,
          color: _getTextColor(context),
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Color _getBackgroundColor(BuildContext context) {
    switch (status.toLowerCase()) {
      case 'approved':
        return context.colors.successLight;
      case 'pending':
        return context.colors.warningLight;
      case 'rejected':
        return context.colors.errorLight;
      default:
        return context.colors.surface100;
    }
  }

  Color _getTextColor(BuildContext context) {
    switch (status.toLowerCase()) {
      case 'approved':
        return context.colors.successDark;
      case 'pending':
        return context.colors.warningDark;
      case 'rejected':
        return context.colors.errorDark;
      default:
        return context.colors.surface600;
    }
  }

  String _getStatusText() {
    if (status.toLowerCase() == 'approved' && approvedBy != null) {
      return 'APPROVED BY: ${approvedBy!.toUpperCase()}';
    }
    return status.toUpperCase();
  }
}
