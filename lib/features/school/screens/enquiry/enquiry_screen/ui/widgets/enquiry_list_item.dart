import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/core/routes/app_router.gr.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';
import '../../../../../models/enquiry_model.dart';

class EnquiryListItem extends StatelessWidget {
  final EnquiryModel enquiry;
  final int index;

  const EnquiryListItem({
    super.key,
    required this.enquiry,
    required this.index,
  });

  // A list of colors for the date circle to match the variety in the screenshot
  static const List<Color> _circleColors = [
    Color(0xFFB39DDB), // Light Purple
    Color(0xFF880E4F), // Deep Maroon
    Color(0xFFAD1457), // Magenta
    Color(0xFFBA68C8), // Orchid
    Color(0xFF5D4037), // Brownish Olive
    Color(0xFF80CBC4), // Teal-ish
    Color(0xFF7CB342), // Lime Green
    Color(0xFF66BB6A), // Green
    Color(0xFFC0CA33), // Yellow-Green
    Color(0xFFFDD835), // Yellow
    Color(0xFFE6EE9C), // Light Gold
    Color(0xFFC2185B), // Raspberry
    Color(0xFFEF9A9A), // Pinkish
  ];

  @override
  Widget build(BuildContext context) {
    final circleColor = _circleColors[index % _circleColors.length];

    return InkWell(
      onTap: () {
        context.router.push(AdmittedDetailsRoute(date: enquiry.date));
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.scale(16),
          vertical: context.scaleHeight(12),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: context.colors.divider.withValues(alpha: 0.5),
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            // 1. Colorful Circular Date Icon
            Container(
              width: context.scale(50),
              height: context.scale(50),
              decoration: BoxDecoration(
                color: circleColor,
                shape: BoxShape.circle,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    enquiry.date.day.toString().padLeft(2, '0'),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: context.scaleFont(18),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat('MMM').format(enquiry.date),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: context.scaleFont(10),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: context.scale(16)),

            // 2. Info Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Admitted : ${enquiry.admittedCount}',
                    style: TextStyle(
                      fontSize: context.scaleFont(16),
                      fontWeight: FontWeight.bold,
                      color: context.colors.textPrimary,
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(2)),
                  Text(
                    'Enquiry : ${enquiry.enquiryCount} , Registration : ${enquiry.registrationCount}',
                    style: TextStyle(
                      fontSize: context.scaleFont(13),
                      color: context.colors.textSecondary,
                      fontWeight: FontWeight.w400,
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
