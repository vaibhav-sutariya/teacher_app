import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../core/routes/app_router.gr.dart';
import '../models/remark_model.dart';

/// Production-ready remark card widget
/// Optimized for performance with RepaintBoundary and ValueKey
class RemarkCard extends StatelessWidget {
  final RemarkModel remark;

  const RemarkCard({super.key, required this.remark});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: ValueKey(remark.id),
      child: InkWell(
        onTap: () {
          context.router.push(RemarkDetailRoute(remark: remark));
        },
        borderRadius: BorderRadius.circular(context.scale(12)),
        child: Container(
          margin: EdgeInsets.only(
            left: context.scale(16),
            right: context.scale(16),
            bottom: context.scaleHeight(8),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(context.scale(12)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(context.scale(16)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon container
                _buildIcon(context),
                SizedBox(width: context.scale(12)),
                // Content
                Expanded(child: _buildContent(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    final isPositive = remark.type == RemarkType.positive;
    final iconColor = isPositive
        ? const Color(0xFF4CAF50)
        : const Color(0xFFE53935);
    final backgroundColor = isPositive
        ? const Color(0xFFE8F5E9)
        : const Color(0xFFFFEBEE);

    IconData iconData;
    if (isPositive) {
      // Positive icons
      switch (remark.category) {
        case RemarkCategory.dailyRoutine:
          iconData = Icons.check_circle;
          break;
        case RemarkCategory.behaviour:
          iconData = Icons.sentiment_very_satisfied;
          break;
        case RemarkCategory.classWork:
          iconData = Icons.check_circle;
          break;
      }
    } else {
      // Negative icons
      final description = remark.description?.toLowerCase() ?? '';
      if (description.contains('late')) {
        iconData = Icons.access_time;
      } else if (description.contains('notebook') ||
          description.contains('noteboo')) {
        iconData = Icons.warning;
      } else {
        switch (remark.category) {
          case RemarkCategory.dailyRoutine:
            iconData = Icons.sentiment_very_dissatisfied;
            break;
          case RemarkCategory.behaviour:
            iconData = Icons.warning;
            break;
          case RemarkCategory.classWork:
            iconData = Icons.error_outline;
            break;
        }
      }
    }

    return Container(
      width: context.scale(48),
      height: context.scale(48),
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: Icon(iconData, color: iconColor, size: context.scale(24)),
    );
  }

  Widget _buildContent(BuildContext context) {
    final isPositive = remark.type == RemarkType.positive;
    final textColor = isPositive
        ? const Color(0xFF4CAF50)
        : const Color(0xFFE53935);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Date and badge row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date
            Expanded(
              child: Text(
                _formatDate(remark.date),
                style: TextStyle(
                  fontSize: context.scaleFont(12),
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // Severity badge
            if (remark.severity != null) _buildSeverityBadge(context),
          ],
        ),
        SizedBox(height: context.scaleHeight(6)),
        // Category
        Text(
          _getCategoryLabel(remark.category),
          style: TextStyle(
            fontSize: context.scaleFont(13),
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1A1A1A),
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: context.scaleHeight(6)),
        // Description
        Text(
          remark.description ?? '',
          style: TextStyle(
            fontSize: context.scaleFont(14),
            color: textColor,
            fontWeight: FontWeight.w500,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildSeverityBadge(BuildContext context) {
    final severity = remark.severity!;
    final isPositive = severity == RemarkSeverity.excellent;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.scale(8),
        vertical: context.scaleHeight(4),
      ),
      decoration: BoxDecoration(
        color: isPositive ? const Color(0xFFC8E6C9) : const Color(0xFFFFCDD2),
        borderRadius: BorderRadius.circular(context.scale(12)),
      ),
      child: Text(
        severity == RemarkSeverity.excellent ? 'EXCELLENT' : 'CRITICAL',
        style: TextStyle(
          fontSize: context.scaleFont(10),
          fontWeight: FontWeight.w700,
          color: isPositive ? const Color(0xFF2E7D32) : const Color(0xFFC62828),
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return '';
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('dd MMM yyyy').format(date).toUpperCase();
    } catch (e) {
      return dateString;
    }
  }

  String _getCategoryLabel(RemarkCategory category) {
    switch (category) {
      case RemarkCategory.dailyRoutine:
        return 'DAILY ROUTINE';
      case RemarkCategory.behaviour:
        return 'BEHAVIOUR';
      case RemarkCategory.classWork:
        return 'CLASS WORK';
    }
  }
}
