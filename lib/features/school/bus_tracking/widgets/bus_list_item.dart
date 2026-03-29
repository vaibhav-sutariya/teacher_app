import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';
import '../models/bus_model.dart';

class BusListItem extends StatelessWidget {
  final BusModel bus;

  const BusListItem({super.key, required this.bus});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.scale(16),
        vertical: context.scaleHeight(8),
      ),
      padding: EdgeInsets.all(context.scale(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.scale(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header with Status Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(context.scale(8)),
                    decoration: BoxDecoration(
                      color: context.colors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(context.scale(8)),
                    ),
                    child: Icon(
                      Icons.directions_bus_outlined,
                      color: context.colors.primary,
                      size: context.scale(24),
                    ),
                  ),
                  SizedBox(width: context.scale(12)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bus.busNumber,
                        style: TextStyle(
                          fontSize: context.scaleFont(16),
                          fontWeight: FontWeight.bold,
                          color: context.colors.textPrimary,
                        ),
                      ),
                      Text(
                        bus.routeName,
                        style: TextStyle(
                          fontSize: context.scaleFont(13),
                          color: context.colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              _StatusBadge(status: bus.status),
            ],
          ),
          
          SizedBox(height: context.scaleHeight(16)),
          const Divider(height: 1),
          SizedBox(height: context.scaleHeight(16)),

          // 2. Location and Info Row
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: context.colors.primary,
                size: context.scale(18),
              ),
              SizedBox(width: context.scale(8)),
              Expanded(
                child: Text(
                  bus.lastLocation,
                  style: TextStyle(
                    fontSize: context.scaleFont(13),
                    color: context.colors.textPrimary.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                bus.speed,
                style: TextStyle(
                  fontSize: context.scaleFont(13),
                  fontWeight: FontWeight.bold,
                  color: context.colors.primary,
                ),
              ),
            ],
          ),
          
          SizedBox(height: context.scaleHeight(12)),

          // 3. Driver Info and Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: context.scale(14),
                    backgroundColor: context.colors.surface200,
                    child: Icon(
                      Icons.person_outline,
                      size: context.scale(16),
                      color: context.colors.textSecondary,
                    ),
                  ),
                  SizedBox(width: context.scale(8)),
                  Text(
                    bus.driverName,
                    style: TextStyle(
                      fontSize: context.scaleFont(13),
                      color: context.colors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  _ActionButton(
                    icon: Icons.call_outlined,
                    color: context.colors.success,
                    label: 'Call',
                    onTap: () {},
                  ),
                  SizedBox(width: context.scale(8)),
                  _ActionButton(
                    icon: Icons.track_changes_outlined,
                    color: context.colors.primary,
                    label: 'Track',
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
          
          SizedBox(height: context.scaleHeight(8)),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Last updated: ${DateFormat('hh:mm a').format(bus.lastUpdated)}',
              style: TextStyle(
                fontSize: context.scaleFont(10),
                color: context.colors.textSecondary.withValues(alpha: 0.6),
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final BusStatus status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;
    bool pulsing = false;

    switch (status) {
      case BusStatus.running:
        color = context.colors.success;
        label = 'RUNNING';
        pulsing = true;
        break;
      case BusStatus.stopped:
        color = context.colors.error;
        label = 'STOPPED';
        break;
      case BusStatus.delayed:
        color = context.colors.warning;
        label = 'DELAYED';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.scale(10),
        vertical: context.scaleHeight(6),
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(context.scale(20)),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (pulsing) ...[
            _PulsingDot(color: color),
            SizedBox(width: context.scale(6)),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: context.scaleFont(10),
              fontWeight: FontWeight.bold,
              color: color,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _PulsingDot extends StatefulWidget {
  final Color color;
  const _PulsingDot({required this.color});

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Container(
        width: context.scale(8),
        height: context.scale(8),
        decoration: BoxDecoration(
          color: widget.color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(context.scale(8)),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.scale(10),
          vertical: context.scaleHeight(6),
        ),
        decoration: BoxDecoration(
          border: Border.all(color: color.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(context.scale(8)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: context.scale(16)),
            SizedBox(width: context.scale(4)),
            Text(
              label,
              style: TextStyle(
                fontSize: context.scaleFont(11),
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
