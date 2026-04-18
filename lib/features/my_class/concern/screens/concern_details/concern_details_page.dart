import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';
import 'package:teachers_app/core/widgets/app_primary_button.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';
import 'package:teachers_app/features/my_class/concern/models/concern_model.dart';
import '../resolve_concern/widgets/resolve_concern_bottom_sheet.dart';

@RoutePage()
class ConcernDetailsPage extends StatefulWidget {
  final ConcernModel concern;

  const ConcernDetailsPage({super.key, required this.concern});

  @override
  State<ConcernDetailsPage> createState() => _ConcernDetailsPageState();
}

class _ConcernDetailsPageState extends State<ConcernDetailsPage> {
  late ConcernModel _currentConcern;

  @override
  void initState() {
    super.initState();
    _currentConcern = widget.concern;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface100,
      appBar: const AppAppBar(title: 'Concern Details'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(context.scale(16)),
        child: Column(
          children: [
            _buildStudentHeader(context),
            SizedBox(height: context.scaleHeight(16)),
            _buildConcernCard(context),
            SizedBox(height: context.scaleHeight(16)),
            if (_currentConcern.status == ConcernStatus.closed)
              _buildResolutionCard(context),
            SizedBox(height: context.scaleHeight(32)),
          ],
        ),
      ),
      bottomNavigationBar: _currentConcern.status != ConcernStatus.closed
          ? _buildBottomAction(context)
          : null,
    );
  }

  Widget _buildStudentHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.scale(16)),
      decoration: BoxDecoration(
        color: context.colors.textInverse,
        borderRadius: BorderRadius.circular(context.scale(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: context.scale(30),
            backgroundImage: _currentConcern.studentAvatar != null
                ? NetworkImage(_currentConcern.studentAvatar!)
                : null,
            child: _currentConcern.studentAvatar == null
                ? Icon(Icons.person, size: context.scale(30))
                : null,
          ),
          SizedBox(width: context.scale(16)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _currentConcern.studentName,
                  style: TextStyle(
                    fontSize: context.scaleFont(18),
                    fontWeight: FontWeight.bold,
                    color: context.colors.textPrimary,
                  ),
                ),
                Text(
                  _currentConcern.studentGrade,
                  style: TextStyle(
                    fontSize: context.scaleFont(14),
                    color: context.colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          _buildStatusBadge(context),
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
        color: _currentConcern.statusColor,
        borderRadius: BorderRadius.circular(context.scale(12)),
      ),
      child: Text(
        _currentConcern.statusLabel,
        style: TextStyle(
          fontSize: context.scaleFont(11),
          fontWeight: FontWeight.bold,
          color: _currentConcern.statusTextColor,
        ),
      ),
    );
  }

  Widget _buildConcernCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.scale(20)),
      decoration: BoxDecoration(
        color: context.colors.textInverse,
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
                'CONCERN DETAILS',
                style: TextStyle(
                  fontSize: context.scaleFont(12),
                  fontWeight: FontWeight.bold,
                  color: context.colors.secondary,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                _currentConcern.ticketNumber,
                style: TextStyle(
                  fontSize: context.scaleFont(12),
                  color: context.colors.textTertiary,
                ),
              ),
            ],
          ),
          SizedBox(height: context.scaleHeight(16)),
          Text(
            _currentConcern.title,
            style: TextStyle(
              fontSize: context.scaleFont(18),
              fontWeight: FontWeight.bold,
              color: context.colors.textPrimary,
            ),
          ),
          SizedBox(height: context.scaleHeight(8)),
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 14,
                color: context.colors.textSecondary,
              ),
              SizedBox(width: context.scale(6)),
              Text(
                DateFormat(
                  'MMM dd, yyyy  hh:mm a',
                ).format(_currentConcern.date),
                style: TextStyle(
                  fontSize: context.scaleFont(12),
                  color: context.colors.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: context.scaleHeight(20)),
          Text(
            _currentConcern.description ?? 'No description provided.',
            style: TextStyle(
              fontSize: context.scaleFont(14),
              color: context.colors.textPrimary,
              height: 1.5,
            ),
          ),
          SizedBox(height: context.scaleHeight(20)),
          _buildInfoRow(
            context,
            'Department',
            _currentConcern.department,
            Icons.business_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildResolutionCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.scale(20)),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F8E9), // Very light green
        borderRadius: BorderRadius.circular(context.scale(20)),
        border: Border.all(color: Colors.green.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RESOLUTION DETAILS',
            style: TextStyle(
              fontSize: context.scaleFont(12),
              fontWeight: FontWeight.bold,
              color: Colors.green[800],
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: context.scaleHeight(16)),
          Text(
            _currentConcern.resolution ?? 'No resolution comment.',
            style: TextStyle(
              fontSize: context.scaleFont(14),
              color: context.colors.textPrimary,
              height: 1.5,
            ),
          ),
          if (_currentConcern.resolutionDate != null) ...[
            SizedBox(height: context.scaleHeight(12)),
            Row(
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  size: 14,
                  color: Colors.green,
                ),
                SizedBox(width: context.scale(6)),
                Text(
                  'Resolved on ${DateFormat('MMM dd, yyyy').format(_currentConcern.resolutionDate!)}',
                  style: TextStyle(
                    fontSize: context.scaleFont(12),
                    color: Colors.green[800],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
          if (_currentConcern.proofImages.isNotEmpty) ...[
            SizedBox(height: context.scaleHeight(20)),
            Text(
              'Proof Images',
              style: TextStyle(
                fontSize: context.scaleFont(13),
                fontWeight: FontWeight.bold,
                color: context.colors.textPrimary,
              ),
            ),
            SizedBox(height: context.scaleHeight(12)),
            SizedBox(
              height: context.scaleHeight(80),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _currentConcern.proofImages.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: context.scale(12)),
                    width: context.scale(80),
                    height: context.scale(80),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(context.scale(12)),
                      image: DecorationImage(
                        image: FileImage(
                          File(_currentConcern.proofImages[index]),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(context.scale(20)),
        child: AppPrimaryButton(
          onPressed: () async {
            final result = await ResolveConcernBottomSheet.show(
              context,
              _currentConcern,
            );
            if (result == true && context.mounted) {
              // In mock, we can manually update the state here or pop with true
              // To make it look real, let's just pop back to list and refresh
              context.router.maybePopTop(true);
            }
          },
          text: 'TAKE ACTION',
        ),
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
      children: [
        Icon(icon, size: 18, color: context.colors.textSecondary),
        SizedBox(width: context.scale(12)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: context.scaleFont(12),
                color: context.colors.textSecondary,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: context.scaleFont(14),
                fontWeight: FontWeight.w600,
                color: context.colors.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
