import 'package:flutter/material.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../cubit/theme_cubit.dart';
import '../models/student_list_model.dart';

class StudentPhotoItem extends StatelessWidget {
  final StudentListModel student;
  final VoidCallback onTap;

  const StudentPhotoItem({
    super.key,
    required this.student,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.scale(16),
          vertical: context.scaleHeight(12),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Student Photo
            Hero(
              tag: 'student_photo_${student.id}',
              child: Container(
                width: context.scale(55),
                height: context.scale(55),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: student.photoUrl != null
                      ? DecorationImage(
                          image: NetworkImage(student.photoUrl!),
                          fit: BoxFit.cover,
                        )
                      : null,
                  color: Colors.grey.shade200,
                ),
                child: student.photoUrl == null
                    ? Icon(Icons.person, color: Colors.grey.shade400)
                    : null,
              ),
            ),
            SizedBox(width: context.scale(16)),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    student.name,
                    style: TextStyle(
                      fontSize: context.scaleFont(15),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(4)),
                  Text(
                    'Class: ${student.className} | Roll No: ${student.rollNo}',
                    style: TextStyle(
                      fontSize: context.scaleFont(13),
                      color: context.colors.textSecondary,
                    ),
                  ),
                  if (student.isUploaded) ...[
                    SizedBox(height: context.scaleHeight(4)),
                    Text(
                      'Uploaded',
                      style: TextStyle(
                        fontSize: context.scaleFont(13),
                        fontWeight: FontWeight.w600,
                        color: Colors.green.shade600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
