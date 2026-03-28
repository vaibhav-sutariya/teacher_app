import 'package:flutter/material.dart';
import '../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../core/routes/app_router.gr.dart';
import '../../../../../cubit/theme_cubit.dart';
import '../../models/holiday_hw_model.dart';
import 'package:auto_route/auto_route.dart';

class HolidayHwCard extends StatelessWidget {
  final HolidayHwModel homework;

  const HolidayHwCard({super.key, required this.homework});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.scaleHeight(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.scale(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => context.router.push(PdfViewerRoute(
            pdfUrl: homework.pdfUrl,
            title: homework.type,
          )),
          borderRadius: BorderRadius.circular(context.scale(16)),
          child: Padding(
            padding: EdgeInsets.all(context.scale(16)),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(context.scale(12)),
                  decoration: BoxDecoration(
                    color: homework.color.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.beach_access_outlined,
                    color: homework.color,
                    size: context.scale(24),
                  ),
                ),
                SizedBox(width: context.scale(16)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        homework.subject,
                        style: TextStyle(
                          fontSize: context.scaleFont(16),
                          fontWeight: FontWeight.bold,
                          color: context.colors.textPrimary,
                        ),
                      ),
                      SizedBox(height: context.scaleHeight(4)),
                      Text(
                        homework.type,
                        style: TextStyle(
                          fontSize: context.scaleFont(14),
                          color: context.colors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: context.colors.textTertiary,
                  size: context.scale(16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
