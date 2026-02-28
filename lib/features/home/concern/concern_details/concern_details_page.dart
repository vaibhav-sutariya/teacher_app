import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../core/widgets/app_app_bar.dart';
import '../models/concern_model.dart';
import 'package:intl/intl.dart';

@RoutePage()
class ConcernDetailsPage extends StatelessWidget {
  final ConcernModel concern;

  const ConcernDetailsPage({super.key, required this.concern});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: const AppAppBar(title: 'Concern Details'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(context.scale(16)),
        child: Column(
          children: [
            _buildHeaderCard(context),
            SizedBox(height: context.scaleHeight(16)),
            _buildDetailsCard(context),
            SizedBox(height: context.scaleHeight(16)),
            if (concern.description != null && concern.description!.isNotEmpty)
              _buildDescriptionCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.scale(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.scale(16)),
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
                  fontSize: context.scaleFont(14),
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF5C6BC0),
                  letterSpacing: 0.5,
                ),
              ),
              _buildStatusBadge(context),
            ],
          ),
          SizedBox(height: context.scaleHeight(12)),
          Text(
            concern.title,
            style: TextStyle(
              fontSize: context.scaleFont(18),
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: context.scaleHeight(8)),
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: context.scale(14),
                color: Colors.grey[600],
              ),
              SizedBox(width: context.scale(6)),
              Text(
                DateFormat('MMM dd, yyyy  hh:mm a').format(concern.date),
                style: TextStyle(
                  fontSize: context.scaleFont(12),
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.scale(12),
        vertical: context.scale(6),
      ),
      decoration: BoxDecoration(
        color: concern.statusColor,
        borderRadius: BorderRadius.circular(context.scale(12)),
      ),
      child: Text(
        concern.statusLabel,
        style: TextStyle(
          fontSize: context.scaleFont(12),
          fontWeight: FontWeight.bold,
          color: concern.statusTextColor,
        ),
      ),
    );
  }

  Widget _buildDetailsCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.scale(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.scale(16)),
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
          _buildInfoRow(
            context,
            'Department',
            concern.department,
            Icons.business_outlined,
          ),
          Divider(
            color: Colors.grey.withValues(alpha: 0.1),
            height: context.scaleHeight(24),
          ),
          // Add more fields if available in model, for now just department is explicit in list item
          _buildInfoRow(context, 'Ticket ID', concern.id, Icons.tag),
        ],
      ),
    );
  }

  Widget _buildDescriptionCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.scale(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.scale(16)),
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
            children: [
              Icon(
                Icons.description_outlined,
                size: context.scale(18),
                color: const Color(0xFF5C6BC0),
              ),
              SizedBox(width: context.scale(8)),
              Text(
                'Description',
                style: TextStyle(
                  fontSize: context.scaleFont(14),
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF3F51B5),
                ),
              ),
            ],
          ),
          SizedBox(height: context.scaleHeight(12)),
          Text(
            concern.description!,
            style: TextStyle(
              fontSize: context.scaleFont(14),
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: context.scale(18), color: Colors.grey[500]),
        SizedBox(width: context.scale(12)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: context.scaleFont(12),
                  color: Colors.grey[500],
                ),
              ),
              SizedBox(height: context.scaleHeight(4)),
              Text(
                value,
                style: TextStyle(
                  fontSize: context.scaleFont(14),
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
