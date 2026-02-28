import 'package:flutter/material.dart';

import '../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../models/leave_detail_model.dart';

/// Activity log item widget for timeline display
/// Shows colored dot, title, subtitle, and timestamp
class ActivityLogItemWidget extends StatelessWidget {
  final ActivityLogItem item;
  final bool isLast;

  const ActivityLogItemWidget({
    super.key,
    required this.item,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator
          Column(
            children: [
              // Dot
              Container(
                width: context.scale(12),
                height: context.scale(12),
                decoration: BoxDecoration(
                  color: _getDotColor(),
                  shape: BoxShape.circle,
                ),
              ),
              // Line (if not last)
              if (!isLast)
                Container(
                  width: context.scale(2),
                  height: context.scaleHeight(40),
                  color: Colors.grey[300],
                  margin: EdgeInsets.symmetric(
                    vertical: context.scaleHeight(4),
                  ),
                ),
            ],
          ),
          SizedBox(width: context.scale(16)),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: context.scaleFont(14),
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: context.scaleHeight(4)),
                Text(
                  item.subtitle,
                  style: TextStyle(
                    fontSize: context.scaleFont(12),
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getDotColor() {
    switch (item.type) {
      case ActivityType.approved:
        return const Color(0xFF4CAF50);
      case ActivityType.submitted:
        return const Color(0xFF9C27B0);
      case ActivityType.rejected:
        return const Color(0xFFF44336);
    }
  }
}
