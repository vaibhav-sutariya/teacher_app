import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../../../core/routes/app_router.gr.dart';
import '../../../../models/admission_class_model.dart';

class AdmissionClassItem extends StatelessWidget {
  final AdmissionClassModel admissionClass;
  final DateTime date;

  const AdmissionClassItem({
    super.key,
    required this.admissionClass,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushRoute(
          AdmissionStudentListRoute(
            className: admissionClass.className,
            date: date,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.scale(16),
          vertical: context.scaleHeight(16),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                admissionClass.className,
                style: TextStyle(
                  fontSize: context.scaleFont(15),
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            Text(
              '${admissionClass.count}',
              style: TextStyle(
                fontSize: context.scaleFont(16),
                fontWeight: FontWeight.w500,
                color: Colors.blue.shade400,
              ),
            ),
            SizedBox(width: context.scale(10)),
            Icon(
              Icons.chevron_right,
              size: context.scale(20),
              color: Colors.grey.shade600,
            ),
          ],
        ),
      ),
    );
  }
}
