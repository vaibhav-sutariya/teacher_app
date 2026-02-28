import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../helpers/extensions/responsive_extensions.dart';
import '../routes/app_router.gr.dart';

/// Generic reusable card widget for displaying PDF documents
/// Used by Assignment, Syllabus, and Holiday HW features
class PdfDocumentCard extends StatelessWidget {
  final String id;
  final DateTime date;
  final String subject;
  final String type;
  final Color color;
  final String pdfUrl;
  final IconData icon;

  const PdfDocumentCard({
    super.key,
    required this.id,
    required this.date,
    required this.subject,
    required this.type,
    required this.color,
    required this.pdfUrl,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(PdfViewerRoute(pdfUrl: pdfUrl, title: type));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: context.scaleHeight(12)),
        padding: EdgeInsets.all(context.scale(16)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(context.scale(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Colored Icon
            Container(
              width: context.scale(45),
              height: context.scale(45),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(context.scale(12)),
              ),
              child: Icon(icon, color: Colors.white, size: context.scale(24)),
            ),

            SizedBox(width: context.scale(16)),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date
                  Text(
                    DateFormat('dd/MMM/yyyy').format(date),
                    style: TextStyle(
                      fontSize: context.scaleFont(14),
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),

                  SizedBox(height: context.scaleHeight(2)),

                  // Subject
                  Text(
                    'Subject : $subject',
                    style: TextStyle(
                      fontSize: context.scaleFont(12),
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),

                  SizedBox(height: context.scaleHeight(2)),

                  // Type
                  Text(
                    'Type : $type',
                    style: TextStyle(
                      fontSize: context.scaleFont(12),
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
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
