import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../../../core/routes/app_router.gr.dart';
import '../../../../../../../cubit/theme_cubit.dart';
import '../../../../models/assignment_model.dart';

class AssignmentCard extends StatelessWidget {
  final AssignmentModel assignment;

  const AssignmentCard({super.key, required this.assignment});

  void _openPdf(BuildContext context) {
    context.router.push(
      PdfViewerRoute(
        pdfUrl: assignment.pdfUrl,
        title: '${assignment.subject} Assignment',
      ),
    );
  }

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
          onTap: () => _openPdf(context),
          borderRadius: BorderRadius.circular(context.scale(16)),
          child: Padding(
            padding: EdgeInsets.all(context.scale(16)),
            child: Row(
              children: [
                // Icon/Badge
                Container(
                  width: context.scale(48),
                  height: context.scale(48),
                  decoration: BoxDecoration(
                    color: assignment.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(context.scale(12)),
                  ),
                  child: Icon(
                    Icons.assignment_outlined,
                    color: assignment.color,
                    size: context.scale(24),
                  ),
                ),
                SizedBox(width: context.scale(16)),

                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        assignment.type,
                        style: TextStyle(
                          fontSize: context.scaleFont(14),
                          fontWeight: FontWeight.bold,
                          color: context.colors.textPrimary,
                        ),
                      ),
                      SizedBox(height: context.scaleHeight(4)),
                      Row(
                        children: [
                          Icon(
                            Icons.book_outlined,
                            size: context.scale(14),
                            color: context.colors.textSecondary,
                          ),
                          SizedBox(width: context.scale(4)),
                          Text(
                            assignment.subject,
                            style: TextStyle(
                              fontSize: context.scaleFont(12),
                              color: context.colors.textSecondary,
                            ),
                          ),
                          SizedBox(width: context.scale(12)),
                          Icon(
                            Icons.calendar_today_outlined,
                            size: context.scale(14),
                            color: context.colors.textSecondary,
                          ),
                          SizedBox(width: context.scale(4)),
                          Text(
                            '${assignment.date.day}/${assignment.date.month}/${assignment.date.year}',
                            style: TextStyle(
                              fontSize: context.scaleFont(12),
                              color: context.colors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Trailing Arrow/PDF Icon
                Icon(
                  Icons.picture_as_pdf,
                  color: Colors.redAccent,
                  size: context.scale(24),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
