import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/core/widgets/app_app_bar.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';

import 'package:teachers_app/features/school/models/staff_notice_model.dart';

@RoutePage()
class StaffNoticeDetailsPage extends StatelessWidget {
  final StaffNoticeModel notice;

  const StaffNoticeDetailsPage({super.key, required this.notice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppAppBar(
        title: 'Details',
        backgroundColor: context.colors.warning,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Recipient Name Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: context.scale(16),
                vertical: context.scaleHeight(10),
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade200, width: 1),
                ),
              ),
              child: Text(
                'MALLIKA MEHTA', // Or notice.recipient if added
                style: TextStyle(
                  fontSize: context.scaleFont(15),
                  fontWeight: FontWeight.bold,
                  color: context.colors.warning,
                  letterSpacing: 0.5,
                ),
              ),
            ),

            // 2. Metadata Box
            Container(
              margin: EdgeInsets.all(context.scale(16)),
              padding: EdgeInsets.all(context.scale(12)),
              width: double.infinity,
              decoration: BoxDecoration(
                color: context.colors.warning.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(context.scale(8)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('dd-MMM-yyyy hh:mm a').format(notice.date),
                    style: TextStyle(
                      fontSize: context.scaleFont(14),
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(4)),
                  Text(
                    'Notice By : ${notice.postedBy.toUpperCase()}',
                    style: TextStyle(
                      fontSize: context.scaleFont(12),
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // 3. Notice Content
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.scale(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Notice Content',
                    style: TextStyle(
                      fontSize: context.scaleFont(14),
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(20)),
                  Text(
                    notice.content,
                    style: TextStyle(
                      fontSize: context.scaleFont(14),
                      color: Colors.black87,
                      height: 1.5,
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
