import 'package:flutter/material.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../cubit/theme_cubit.dart';
import '../models/transport_route_model.dart';

class ViewTransportAttendanceCard extends StatelessWidget {
  final TransportRouteModel route;
  final VoidCallback onTap;

  const ViewTransportAttendanceCard({
    super.key,
    required this.route,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.scale(16),
          vertical: context.scaleHeight(16),
        ),
        decoration: BoxDecoration(
          color: context.colors.surface,
          border: Border(
            bottom: BorderSide(color: context.colors.divider, width: 1),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(context.scale(6)),
              decoration: BoxDecoration(
                color: route.isMarked
                    ? context.colors.successLight
                    : context.colors.warningLight,
                shape: BoxShape.circle,
              ),
              child: Icon(
                route.isMarked ? Icons.check_circle : Icons.pending_actions,
                color: route.isMarked ? context.colors.primary : Colors.orange,
                size: context.scale(20),
              ),
            ),
            SizedBox(width: context.scale(16)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    route.routeName.toUpperCase(),
                    style: TextStyle(
                      fontSize: context.scaleFont(16),
                      fontWeight: FontWeight.bold,
                      color: context.colors.textPrimary,
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(4)),
                  Text(
                    '${route.studentCount} Students • Veh: ${route.vehicleNumber}',
                    style: TextStyle(
                      fontSize: context.scaleFont(14),
                      color: context.colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: context.colors.textSecondary.withValues(alpha: 0.5),
              size: context.scale(24),
            ),
          ],
        ),
      ),
    );
  }
}
