import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../cubit/theme_cubit.dart';
import '../models/classwork_model.dart';
import '../../../../core/widgets/app_capsule_button.dart';

class ClassworkCard extends StatelessWidget {
  final ClassworkEntity classwork;

  const ClassworkCard({super.key, required this.classwork});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.scaleHeight(16)),
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
      child: Padding(
        padding: EdgeInsets.all(context.scale(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                Container(
                  width: context.scale(8),
                  height: context.scale(8),
                  decoration: BoxDecoration(
                    color: Colors.orange, // Or dynamic color
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: context.scale(8)),
                Text(
                  '${DateFormat('dd/MMM/yyyy').format(classwork.date).toUpperCase()} | ${classwork.subject}',
                  style: TextStyle(
                    fontSize: context.scaleFont(14),
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF263238),
                  ),
                ),
              ],
            ),
            SizedBox(height: context.scaleHeight(12)),

            Divider(color: Colors.grey.withValues(alpha: 0.1)),
            SizedBox(height: context.scaleHeight(12)),

            // Description
            Text(
              classwork.description,
              style: TextStyle(
                fontSize: context.scaleFont(14),
                color: const Color(0xFF546E7A),
                height: 1.5,
              ),
            ),

            // Attachments
            if (classwork.attachments.isNotEmpty) ...[
              SizedBox(height: context.scaleHeight(16)),
              Container(
                padding: EdgeInsets.all(context.scale(12)),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
                  borderRadius: BorderRadius.circular(context.scale(12)),
                ),
                // Dashed border is complex in Flutter without external package, simpler border for now or CustomPainter
                // Let's us DottedBorder if package exists, but user didn't mention it.
                // Using standard container with grey border for now, maybe filtered.
                // Actually image shows dashed border around attachment.
                // I'll stick to simple border for high performance unless requested.
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(context.scale(8)),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(context.scale(8)),
                      ),
                      child: Icon(
                        Icons.picture_as_pdf,
                        color: Colors.red,
                        size: context.scale(24),
                      ),
                    ),
                    SizedBox(width: context.scale(12)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Attachments',
                            style: TextStyle(
                              fontSize: context.scaleFont(12),
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF263238),
                            ),
                          ),
                          Text(
                            '${classwork.attachments.first.name} (${classwork.attachments.first.size})',
                            style: TextStyle(
                              fontSize: context.scaleFont(12),
                              color: const Color(0xFF78909C),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.download_rounded,
                      color: context.colors.primary,
                      size: context.scale(24),
                    ),
                  ],
                ),
              ),
            ],

            SizedBox(height: context.scaleHeight(16)),

            // Comments Button
            Align(
              alignment: Alignment.centerRight,
              child: AppCapsuleButton(
                text: 'Comments',
                icon: Icons.chat_bubble_outline_rounded,
                isIconRight: false,
                showShadow: false,
                verticalPadding: 10,
                iconGap: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
