import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../core/widgets/app_app_bar.dart';
import 'models/leave_detail_model.dart';
import 'widgets/activity_log_item.dart';
import 'widgets/leave_info_row.dart';
import 'widgets/leave_status_badge.dart';

/// Leave Detail Page
/// Shows complete information about a leave request
/// High performance with RepaintBoundary and const constructors
@RoutePage()
class LeaveDetailPage extends StatelessWidget {
  final String? leaveId;

  const LeaveDetailPage({super.key, @PathParam('id') this.leaveId});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with actual data from repository/bloc
    final leaveDetail = _getMockLeaveDetail();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: const AppAppBar(
        title: 'Leave Details',
        profileImageUrl: 'https://i.pravatar.cc/150?img=1',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(context.scale(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main card containing all leave details
            RepaintBoundary(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(context.scale(16)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(context.scale(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Leave Status Section
                    _buildLeaveStatusSection(context, leaveDetail),
                    SizedBox(height: context.scaleHeight(20)),

                    // Leave Duration Card
                    _buildLeaveDurationCard(context, leaveDetail),
                    SizedBox(height: context.scaleHeight(16)),

                    // Approval Date
                    if (leaveDetail.approvalDate != null)
                      LeaveInfoRow(
                        icon: Icons.event_available,
                        label: 'Approval Date',
                        value: DateFormat(
                          'dd MMM yyyy',
                        ).format(leaveDetail.approvalDate!),
                        iconColor: Colors.green[600],
                      ),

                    // Request Date
                    LeaveInfoRow(
                      icon: Icons.access_time,
                      label: 'Date of Request',
                      value: DateFormat(
                        'dd MMM yyyy, HH:mm',
                      ).format(leaveDetail.requestDate),
                      iconColor: Colors.grey[600],
                    ),

                    SizedBox(height: context.scaleHeight(16)),

                    // Reason Section
                    _buildReasonSection(context, leaveDetail.reason),
                  ],
                ),
              ),
            ),

            SizedBox(height: context.scaleHeight(20)),

            // Activity Log Section
            _buildActivityLogSection(context, leaveDetail.activityLog),
          ],
        ),
      ),
    );
  }

  /// Build leave status section with icon and badge
  Widget _buildLeaveStatusSection(
    BuildContext context,
    LeaveDetailModel leaveDetail,
  ) {
    return Row(
      children: [
        // Leave icon with checkmark
        Container(
          width: context.scale(56),
          height: context.scale(56),
          decoration: BoxDecoration(
            color: const Color(0xFF81C784).withOpacity(0.2),
            borderRadius: BorderRadius.circular(context.scale(12)),
          ),
          child: Stack(
            children: [
              Center(
                child: Icon(
                  Icons.calendar_today,
                  size: context.scale(28),
                  color: const Color(0xFF66BB6A),
                ),
              ),
              if (leaveDetail.isApproved)
                Positioned(
                  right: context.scale(2),
                  bottom: context.scale(2),
                  child: Container(
                    width: context.scale(20),
                    height: context.scale(20),
                    decoration: const BoxDecoration(
                      color: Color(0xFF4CAF50),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      size: context.scale(14),
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(width: context.scale(16)),
        // Status badge
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'LEAVE STATUS',
                style: TextStyle(
                  fontSize: context.scaleFont(11),
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[500],
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: context.scaleHeight(6)),
              LeaveStatusBadge(
                status: leaveDetail.status,
                approvedBy: leaveDetail.approvedBy,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Build leave duration card with calendar icon and days count
  Widget _buildLeaveDurationCard(
    BuildContext context,
    LeaveDetailModel leaveDetail,
  ) {
    return Container(
      padding: EdgeInsets.all(context.scale(16)),
      decoration: BoxDecoration(
        color: const Color(0xFF5C6BC0).withOpacity(0.08),
        borderRadius: BorderRadius.circular(context.scale(12)),
      ),
      child: Row(
        children: [
          // Calendar icon
          Container(
            width: context.scale(48),
            height: context.scale(48),
            decoration: BoxDecoration(
              color: const Color(0xFF5C6BC0).withOpacity(0.15),
              borderRadius: BorderRadius.circular(context.scale(10)),
            ),
            child: Icon(
              Icons.calendar_month,
              size: context.scale(24),
              color: const Color(0xFF5C6BC0),
            ),
          ),
          SizedBox(width: context.scale(16)),
          // Duration info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'LEAVE DURATION',
                  style: TextStyle(
                    fontSize: context.scaleFont(11),
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: context.scaleHeight(4)),
                Text(
                  '${DateFormat('dd MMM').format(leaveDetail.startDate)} — ${DateFormat('dd MMM yyyy').format(leaveDetail.endDate)}',
                  style: TextStyle(
                    fontSize: context.scaleFont(14),
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          // Days count
          Column(
            children: [
              Text(
                'DAYS',
                style: TextStyle(
                  fontSize: context.scaleFont(10),
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[500],
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: context.scaleHeight(2)),
              Text(
                leaveDetail.days.toString().padLeft(2, '0'),
                style: TextStyle(
                  fontSize: context.scaleFont(24),
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF5C6BC0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build reason section with italic text
  Widget _buildReasonSection(BuildContext context, String reason) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'REASON FOR LEAVE',
          style: TextStyle(
            fontSize: context.scaleFont(11),
            fontWeight: FontWeight.w600,
            color: Colors.grey[500],
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: context.scaleHeight(12)),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(context.scale(16)),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(context.scale(12)),
          ),
          child: Text(
            '"$reason"',
            style: TextStyle(
              fontSize: context.scaleFont(13),
              fontStyle: FontStyle.italic,
              color: Colors.grey[800],
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  /// Build activity log section with timeline
  Widget _buildActivityLogSection(
    BuildContext context,
    List<ActivityLogItem> activityLog,
  ) {
    return RepaintBoundary(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ACTIVITY LOG',
            style: TextStyle(
              fontSize: context.scaleFont(11),
              fontWeight: FontWeight.w600,
              color: Colors.grey[500],
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: context.scaleHeight(16)),
          ...List.generate(
            activityLog.length,
            (index) => ActivityLogItemWidget(
              item: activityLog[index],
              isLast: index == activityLog.length - 1,
            ),
          ),
        ],
      ),
    );
  }

  /// Mock data for demonstration
  LeaveDetailModel _getMockLeaveDetail() {
    return LeaveDetailModel(
      id: '1',
      status: 'approved',
      approvedBy: 'Jigna Panchal',
      startDate: DateTime(2025, 11, 15),
      endDate: DateTime(2025, 11, 17),
      days: 3,
      approvalDate: DateTime(2025, 11, 17),
      requestDate: DateTime(2025, 11, 17, 8, 1),
      reason:
          'I am going to Surat for a wedding ceremony of my cousin. I will ensure all my pending assignments are submitted beforehand.',
      activityLog: [
        ActivityLogItem(
          title: 'Request Approved',
          subtitle: 'by Jigna Panchal • 17 Nov, 08:45 AM',
          timestamp: DateTime(2025, 11, 17, 8, 45),
          type: ActivityType.approved,
        ),
        ActivityLogItem(
          title: 'Request Submitted',
          subtitle: 'by Student • 17 Nov, 08:01 AM',
          timestamp: DateTime(2025, 11, 17, 8, 1),
          type: ActivityType.submitted,
        ),
      ],
    );
  }
}
