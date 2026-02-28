import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../core/widgets/app_app_bar.dart';
import '../../../../core/widgets/app_primary_button.dart';
import '../../../../cubit/theme_cubit.dart';
import '../remarks_screen/models/remark_model.dart';
import 'widgets/action_required_card.dart';
import 'widgets/remark_detail_item.dart';
import 'widgets/teacher_info_section.dart';

/// Production-ready remark detail page
/// Optimized for performance with const widgets and minimal rebuilds
@RoutePage()
class RemarkDetailPage extends StatelessWidget {
  final RemarkModel remark;

  const RemarkDetailPage({super.key, required this.remark});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppAppBar(
        title: 'Remark Detail',
        profileImageUrl: 'https://i.pravatar.cc/150?u=a042581f4e29026024d',
        backgroundColor: context.colors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Main content card
            Container(
              margin: EdgeInsets.all(context.scale(16)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(context.scale(16)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(context.scale(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Teacher Information Section
                    const TeacherInfoSection(),
                    SizedBox(height: context.scaleHeight(24)),
                    // Action Required Card (only for negative remarks with severity)
                    if (remark.type == RemarkType.negative &&
                        remark.severity == RemarkSeverity.critical)
                      ActionRequiredCard(
                        title: 'ACTION REQUIRED',
                        description: remark.description ?? 'Action Required',
                      ),
                    if (remark.type == RemarkType.negative &&
                        remark.severity == RemarkSeverity.critical)
                      SizedBox(height: context.scaleHeight(24)),
                    // Remark Details
                    _RemarkDetailsSection(remark: remark),
                    SizedBox(height: context.scaleHeight(24)),
                    // Teacher's Note Section
                    _TeachersNoteSection(remark: remark),
                    SizedBox(height: context.scaleHeight(24)),
                    // Contact Teacher Button
                    AppPrimaryButton(
                      onPressed: () {
                        // Handle contact teacher
                      },
                      height: context.scaleHeight(40),
                      borderRadius: context.scale(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                            color: Colors.white,
                            size: context.scale(20),
                          ),
                          SizedBox(width: context.scale(8)),
                          Text(
                            'Contact Teacher',
                            style: TextStyle(
                              fontSize: context.scaleFont(16),
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: context.scaleHeight(16)),
                    // Acknowledge Remark Link
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          // Handle acknowledge remark
                        },
                        child: Column(
                          children: [
                            Text(
                              'Acknowledge Remark',
                              style: TextStyle(
                                fontSize: context.scaleFont(14),
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[600],
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            SizedBox(height: context.scaleHeight(4)),
                            Container(
                              width: context.scale(100),
                              height: context.scaleHeight(1),
                              color: Colors.grey[300],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Remark details section widget
/// Optimized with const constructor
class _RemarkDetailsSection extends StatelessWidget {
  final RemarkModel remark;

  const _RemarkDetailsSection({required this.remark});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RemarkDetailItem(
          icon: Icons.calendar_today_outlined,
          iconColor: const Color(0xFF1976D2),
          label: 'Date',
          value: _formatDate(remark.date),
        ),
        SizedBox(height: context.scaleHeight(16)),
        RemarkDetailItem(
          icon: Icons.category_outlined,
          iconColor: const Color(0xFFFF9800),
          label: 'Category',
          value: _getCategoryLabel(remark.category),
        ),
        SizedBox(height: context.scaleHeight(16)),
        RemarkDetailItem(
          icon: Icons.trending_down_outlined,
          iconColor: remark.type == RemarkType.positive
              ? const Color(0xFF4CAF50)
              : const Color(0xFFE53935),
          label: 'Evaluation Type',
          value: remark.type == RemarkType.positive
              ? 'Positive Remark'
              : 'Negative Remark',
          valueColor: remark.type == RemarkType.positive
              ? const Color(0xFF4CAF50)
              : const Color(0xFFE53935),
          showDot: true,
        ),
      ],
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return '';
    try {
      final date = DateTime.parse(dateString);
      return '${date.day} ${_getMonthAbbr(date.month)} ${date.year}';
    } catch (e) {
      return dateString;
    }
  }

  String _getMonthAbbr(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  String _getCategoryLabel(RemarkCategory category) {
    switch (category) {
      case RemarkCategory.dailyRoutine:
        return 'Daily Routine';
      case RemarkCategory.behaviour:
        return 'Behaviour';
      case RemarkCategory.classWork:
        return 'Class Work';
    }
  }
}

/// Teacher's note section widget
/// Optimized with const constructor
class _TeachersNoteSection extends StatelessWidget {
  final RemarkModel remark;

  const _TeachersNoteSection({required this.remark});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu, color: Colors.grey[700], size: context.scale(20)),
            SizedBox(width: context.scale(8)),
            Text(
              "Teacher's Note",
              style: TextStyle(
                fontSize: context.scaleFont(16),
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1A1A1A),
              ),
            ),
          ],
        ),
        SizedBox(height: context.scaleHeight(12)),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(context.scale(16)),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(context.scale(12)),
          ),
          child: Text(
            remark.description ?? 'No note available.',
            style: TextStyle(
              fontSize: context.scaleFont(14),
              color: Colors.grey[800],
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
