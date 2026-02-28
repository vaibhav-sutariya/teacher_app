import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../cubit/theme_cubit.dart';
import '../models/homework_model.dart';
import '../../../../core/widgets/app_capsule_button.dart';

class HomeworkCard extends StatelessWidget {
  final HomeworkEntity homework;

  const HomeworkCard({super.key, required this.homework});

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
      child: Padding(
        padding: EdgeInsets.all(context.scale(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Icon, Date, Subject
            Row(
              children: [
                Icon(
                  Icons.description_outlined,
                  color: context.colors.primary,
                  size: context.scale(20),
                ),
                SizedBox(width: context.scale(8)),
                Text(
                  '${DateFormat('dd/MM/yyyy').format(homework.date)} | ${homework.subject}',
                  style: TextStyle(
                    fontSize: context.scaleFont(14),
                    fontWeight: FontWeight.bold,
                    color: context.colors.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: context.scaleHeight(16)),
            // Description
            Text(
              homework.description,
              style: TextStyle(
                fontSize: context.scaleFont(14),
                color: const Color(0xFF455A64),
                height: 1.5,
              ),
            ),
            SizedBox(height: context.scaleHeight(24)),

            // Details Rows
            _buildDetailRow(
              context,
              label: 'Subject Teacher',
              value: homework.teacherName,
              valueColor: const Color(0xFF263238),
              isBoldValue: true,
            ),
            SizedBox(height: context.scaleHeight(12)),
            _buildDetailRow(
              context,
              label: 'Submission Date',
              value: DateFormat('dd/MM/yyyy').format(homework.submissionDate),
              valueColor: const Color(0xFF263238),
              isBoldValue: true,
            ),
            SizedBox(height: context.scaleHeight(12)),
            _buildDetailRow(
              context,
              label: 'Status',
              value: homework.status == HomeworkStatus.pending
                  ? 'Pending'
                  : 'Submitted',
              valueColor: homework.status == HomeworkStatus.pending
                  ? const Color(0xFFFF6D00)
                  : const Color(0xFF2E7D32),
              isBoldValue: true,
              hasBullet: true,
            ),

            SizedBox(height: context.scaleHeight(24)),

            // Submit Button
            if (homework.status == HomeworkStatus.pending)
              Align(
                alignment: Alignment.centerRight,
                child: AppCapsuleButton(
                  text: 'Submit',
                  icon: Icons.arrow_forward_rounded,
                  isIconRight: true,
                  fontSize: 16,
                  iconGap: 4,
                  // onTap: () {}, // Add functionality later
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required String label,
    required String value,
    required Color valueColor,
    bool isBoldValue = false,
    bool hasBullet = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: context.scaleFont(14),
            color: const Color(0xFF90A4AE),
          ),
        ),
        Row(
          children: [
            if (hasBullet)
              Container(
                margin: EdgeInsets.only(right: context.scale(6)),
                width: context.scale(6),
                height: context.scale(6),
                decoration: BoxDecoration(
                  color: valueColor,
                  shape: BoxShape.circle,
                ),
              ),
            Text(
              value,
              style: TextStyle(
                fontSize: context.scaleFont(14),
                fontWeight: isBoldValue ? FontWeight.bold : FontWeight.normal,
                color: valueColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
