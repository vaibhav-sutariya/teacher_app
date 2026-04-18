import 'package:flutter/material.dart';
import '../../../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../models/admission_student_model.dart';

class AdmissionStudentItem extends StatelessWidget {
  final AdmissionStudentModel student;

  const AdmissionStudentItem({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.scale(16),
        vertical: context.scaleHeight(14),
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
          // Roll No
          SizedBox(
            width: context.scale(60),
            child: Text(
              student.rollNo,
              style: TextStyle(
                fontSize: context.scaleFont(14),
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          // GR No
          SizedBox(
            width: context.scale(80),
            child: Text(
              student.grNo,
              style: TextStyle(
                fontSize: context.scaleFont(14),
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          // Name
          Expanded(
            child: Text(
              student.name,
              style: TextStyle(
                fontSize: context.scaleFont(14),
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
