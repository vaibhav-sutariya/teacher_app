import 'package:flutter/material.dart';

import '../../../../../core/helpers/extensions/responsive_extensions.dart';

/// Reusable info row widget for displaying leave information
/// Shows icon, label, and value in a row
class LeaveInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? iconColor;

  const LeaveInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.scaleHeight(8)),
        child: Row(
          children: [
            // Icon
            Container(
              width: context.scale(40),
              height: context.scale(40),
              decoration: BoxDecoration(
                color: (iconColor ?? Colors.grey[400])!.withOpacity(0.1),
                borderRadius: BorderRadius.circular(context.scale(8)),
              ),
              child: Icon(
                icon,
                size: context.scale(20),
                color: iconColor ?? Colors.grey[600],
              ),
            ),
            SizedBox(width: context.scale(12)),
            // Label and Value
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: context.scaleFont(13),
                      color: Colors.grey[700],
                    ),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: context.scaleFont(13),
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
