import 'package:flutter/material.dart';

import '../../../../../core/helpers/extensions/responsive_extensions.dart';

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
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(context.scale(4)),
      ),
      child: Text(
        _getStatusText(),
        style: TextStyle(
          fontSize: context.scaleFont(11),
          fontWeight: FontWeight.bold,
          color: _getTextColor(),
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (status.toLowerCase()) {
      case 'approved':
        return const Color(0xFFE8F5E9);
      case 'pending':
        return const Color(0xFFFFF3E0);
      case 'rejected':
        return const Color(0xFFFFEBEE);
      default:
        return const Color(0xFFF5F5F5);
    }
  }

  Color _getTextColor() {
    switch (status.toLowerCase()) {
      case 'approved':
        return const Color(0xFF2E7D32);
      case 'pending':
        return const Color(0xFFF57C00);
      case 'rejected':
        return const Color(0xFFC62828);
      default:
        return const Color(0xFF616161);
    }
  }

  String _getStatusText() {
    if (status.toLowerCase() == 'approved' && approvedBy != null) {
      return 'APPROVED BY: ${approvedBy!.toUpperCase()}';
    }
    return status.toUpperCase();
  }
}
