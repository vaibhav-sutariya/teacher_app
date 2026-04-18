import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../../../core/routes/app_router.gr.dart';
import '../../../../../../../cubit/theme_cubit.dart';
import '../../../../models/time_table_model.dart';

class TimeTableCard extends StatelessWidget {
  final TimeTableModel timetable;

  const TimeTableCard({super.key, required this.timetable});

  void _openPdf(BuildContext context) {
    context.router.push(
      PdfViewerRoute(
        pdfUrl: timetable.pdfUrl,
        title: '${timetable.className}-${timetable.divisionName} Table',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final firstLetter = timetable.className.isNotEmpty
        ? timetable.className[0]
        : '';
    final circleColor = _getCircleColor(
      timetable.type ?? timetable.divisionName,
    );

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.scale(16),
        vertical: context.scaleHeight(8),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.scale(12)),
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
          onTap: () => _openPdf(context),
          borderRadius: BorderRadius.circular(context.scale(12)),
          child: Padding(
            padding: EdgeInsets.all(context.scale(12)),
            child: Row(
              children: [
                // Circular Grade Initial
                Container(
                  width: context.scale(48),
                  height: context.scale(48),
                  decoration: BoxDecoration(
                    color: circleColor.withValues(alpha: 0.8),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      firstLetter,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: context.scaleFont(18),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: context.scale(16)),

                // Class and Teacher Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${timetable.className}-${timetable.divisionName}',
                        style: TextStyle(
                          fontSize: context.scaleFont(16),
                          fontWeight: FontWeight.bold,
                          color: context.colors.textPrimary,
                        ),
                      ),
                      SizedBox(height: context.scaleHeight(4)),
                      Text(
                        'Class Teacher : ${timetable.classTeacherName}',
                        style: TextStyle(
                          fontSize: context.scaleFont(12),
                          color: context.colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                // PDF Icon
                IconButton(
                  onPressed: () => _openPdf(context),
                  icon: Icon(
                    Icons.picture_as_pdf,
                    color: Colors.redAccent,
                    size: context.scale(28),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getCircleColor(String type) {
    switch (type.toUpperCase()) {
      case 'JAL':
        return Colors.blue;
      case 'VAYU':
        return Colors.orange;
      case 'AAKASH':
        return Colors.brown;
      case 'PRITHVI':
        return Colors.green;
      case 'TEJ':
        return Colors.lightBlueAccent;
      default:
        return Colors.grey;
    }
  }
}
