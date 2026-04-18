import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';
import '../../../../../models/history_model.dart';
import '../../../../../models/staff_model.dart';

class StaffHistoryHeader extends StatelessWidget
    implements PreferredSizeWidget {
  final StaffMember staff;

  const StaffHistoryHeader({super.key, required this.staff});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        bottom: context.scaleHeight(15),
      ),
      decoration: BoxDecoration(
        color: context.colors.primary, // Yellow as per screenshot
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(context.scale(25)),
          bottomRight: Radius.circular(context.scale(25)),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          ),
          CircleAvatar(
            radius: context.scale(22),
            backgroundColor: Colors.white24,
            backgroundImage: staff.profileImage != null
                ? NetworkImage(staff.profileImage!)
                : null,
            child: staff.profileImage == null
                ? const Icon(Icons.person, color: Colors.white)
                : null,
          ),
          SizedBox(width: context.scale(12)),
          Expanded(
            child: Text(
              staff.name.toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: context.scaleFont(18),
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class AttendanceHistoryTile extends StatelessWidget {
  final StaffAttendanceHistoryLog log;

  const AttendanceHistoryTile({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    Color statusColor = Colors.green;
    IconData statusIcon = Icons.check_circle;
    String statusText = '';

    switch (log.status) {
      case StaffHistoryStatus.weekOff:
        statusColor = Colors.yellow.shade700;
        statusIcon = Icons.sentiment_satisfied_alt;
        statusText = 'Week Off';
        break;
      case StaffHistoryStatus.absent:
        statusColor = const Color(0xFFE57373); // Pinkish-red
        statusIcon = Icons.cancel;
        statusText = 'Absent';
        break;
      case StaffHistoryStatus.leave:
        statusColor = Colors.orange;
        statusIcon = Icons.info_outline;
        statusText = 'Leave';
        break;
      case StaffHistoryStatus.holiday:
        statusColor = Colors.blue;
        statusIcon = Icons.event;
        statusText = 'Holiday';
        break;
      case StaffHistoryStatus.present:
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        statusText = 'IN-${log.inTime} | OUT-${log.outTime ?? ''}';
        break;
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.scale(16),
        vertical: context.scaleHeight(10),
      ),
      child: Row(
        children: [
          // 1. Date side
          SizedBox(
            width: context.scale(40),
            child: Column(
              children: [
                Text(
                  DateFormat('EEE').format(log.date),
                  style: TextStyle(
                    fontSize: context.scaleFont(13),
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                ),
                Text(
                  DateFormat('dd').format(log.date),
                  style: TextStyle(
                    fontSize: context.scaleFont(16),
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // 2. Middle Line and Box
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Horizontal Line
                Container(height: 1, color: statusColor.withValues(alpha: 0.3)),
                // Status Box
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.scale(16),
                    vertical: context.scaleHeight(6),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: statusColor.withValues(alpha: 0.5),
                    ),
                    borderRadius: BorderRadius.circular(context.scale(4)),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      fontSize: context.scaleFont(10),
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: context.scale(12)),

          // 3. Status Icon
          Icon(statusIcon, color: statusColor, size: context.scale(26)),
        ],
      ),
    );
  }
}

class AttendanceSummaryFooter extends StatelessWidget {
  final VoidCallback onTap;

  const AttendanceSummaryFooter({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: context.scaleHeight(15)),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.circle, size: 8, color: Colors.grey),
              SizedBox(width: context.scale(8)),
              Text(
                'SUMMARY',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: context.scaleFont(14),
                  letterSpacing: 1.2,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HistorySummaryBottomSheet extends StatelessWidget {
  final int present;
  final int absent;
  final int leave;
  final int holiday;
  final int weekOff;

  const HistorySummaryBottomSheet({
    super.key,
    required this.present,
    required this.absent,
    required this.leave,
    required this.holiday,
    required this.weekOff,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom + context.scaleHeight(20),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(context.scale(20)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.scaleHeight(15)),
            child: Text(
              'SUMMARY',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: context.scaleFont(16),
                color: Colors.grey.shade700,
              ),
            ),
          ),
          const Divider(height: 1),

          // List Items
          _SummaryItem(
            label: 'PRESENT DAYS',
            count: present.toDouble(),
            color: Colors.green,
          ),
          _SummaryItem(
            label: 'ABSENT DAYS',
            count: absent.toDouble(),
            color: const Color(0xFFE57373),
          ),
          _SummaryItem(
            label: 'LEAVE DAYS',
            count: leave.toDouble(),
            color: Colors.orange,
          ),
          _SummaryItem(
            label: 'HOLIDAY',
            count: holiday.toDouble(),
            color: Colors.blue,
          ),
          _SummaryItem(
            label: 'WEEK OFF',
            count: weekOff.toDouble(),
            color: Colors.yellow.shade700,
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final double count;
  final Color color;

  const _SummaryItem({
    required this.label,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.scale(24),
        vertical: context.scaleHeight(12),
      ),
      child: Row(
        children: [
          Container(
            width: context.scale(24),
            height: context.scale(24),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: context.scale(16)),
          Text(
            '$label: ${count == count.toInt() ? count.toInt() : count}',
            style: TextStyle(
              fontSize: context.scaleFont(14),
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
