import 'package:flutter/material.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../models/report_card_model.dart';
import 'package:auto_route/auto_route.dart';
import '../../../../core/routes/app_router.gr.dart';

class ReportCardItem extends StatelessWidget {
  final ReportCardModel report;

  const ReportCardItem({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    if (report.isLocked) {
      return _buildLockedCard(context);
    }

    return Container(
      margin: EdgeInsets.only(bottom: context.scale(16)),
      padding: EdgeInsets.all(context.scale(16)),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      report.termName,
                      style: TextStyle(
                        fontSize: context.scaleFont(16),
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: context.scaleHeight(8)),
                    Row(
                      children: [
                        _buildStatusBadge(context, report.status),
                        SizedBox(width: context.scale(8)),
                        Text(
                          '• ${report.date}',
                          style: TextStyle(
                            fontSize: context.scaleFont(12),
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (report.grade != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      report.grade!,
                      style: TextStyle(
                        fontSize: context.scaleFont(24),
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1A237E), // Deep Blue
                      ),
                    ),
                    Text(
                      report.overallGradeLabel ?? 'OVERALL GRADE',
                      style: TextStyle(
                        fontSize: context.scaleFont(8),
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
            ],
          ),
          SizedBox(height: context.scaleHeight(16)),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: context.scale(44),
                  child: FilledButton.icon(
                    onPressed: () {
                      if (report.pdfUrl != null) {
                        context.router.push(
                          PdfViewerRoute(
                            pdfUrl: report.pdfUrl!,
                            title: report.termName,
                          ),
                        );
                      }
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF1A237E), // Deep Blue
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(context.scale(12)),
                      ),
                    ),
                    icon: Icon(Icons.remove_red_eye, size: context.scale(18)),
                    label: Text(
                      'View Details',
                      style: TextStyle(
                        fontSize: context.scaleFont(14),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: context.scale(12)),
              Container(
                width: context.scale(44),
                height: context.scale(44),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(context.scale(12)),
                ),
                child: IconButton(
                  onPressed: () {
                    // Download logic
                  },
                  icon: Icon(
                    Icons.download_rounded,
                    color: Colors.grey[700],
                    size: context.scale(20),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context, String status) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.scale(8),
        vertical: context.scale(4),
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9), // Light Green
        borderRadius: BorderRadius.circular(context.scale(4)),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: context.scaleFont(10),
          fontWeight: FontWeight.bold,
          color: const Color(0xFF2E7D32), // Dark Green
        ),
      ),
    );
  }

  Widget _buildLockedCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.scale(16)),
      padding: EdgeInsets.all(context.scale(16)),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA), // Very light grey
        borderRadius: BorderRadius.circular(context.scale(16)),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.2),
          style: BorderStyle.solid,
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                report.termName,
                style: TextStyle(
                  fontSize: context.scaleFont(16),
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: context.scaleHeight(8)),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.scale(8),
                  vertical: context.scale(4),
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(context.scale(4)),
                ),
                child: Text(
                  report.status,
                  style: TextStyle(
                    fontSize: context.scaleFont(10),
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              SizedBox(height: context.scaleHeight(16)),
              Text(
                report.lockMessage ?? '',
                style: TextStyle(
                  fontSize: context.scaleFont(12),
                  color: Colors.grey[500],
                  height: 1.4,
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Icon(
              Icons.lock_clock_outlined,
              size: context.scale(48),
              color: Colors.grey.withValues(alpha: 0.2),
            ),
          ),
        ],
      ),
    );
  }
}
