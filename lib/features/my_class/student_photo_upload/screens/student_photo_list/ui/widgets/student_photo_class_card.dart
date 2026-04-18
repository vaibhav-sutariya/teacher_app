import 'package:flutter/material.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import '../../../../models/student_photo_class_model.dart';

class StudentPhotoClassCard extends StatelessWidget {
  final StudentPhotoClassModel classModel;
  final VoidCallback onTap;

  const StudentPhotoClassCard({
    super.key,
    required this.classModel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
                classModel.className,
                style: TextStyle(
                  fontSize: context.scaleFont(15),
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
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
