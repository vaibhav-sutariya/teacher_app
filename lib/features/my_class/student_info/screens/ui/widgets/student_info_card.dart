import 'package:flutter/material.dart';
import '../../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../../cubit/theme_cubit.dart';
import '../../../models/student_model.dart';

class StudentInfoCard extends StatelessWidget {
  final StudentModel student;
  final VoidCallback onTap;

  const StudentInfoCard({
    super.key,
    required this.student,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: context.colors.divider.withValues(alpha: 0.5),
            width: 0.5,
          ),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(
          horizontal: context.scale(20),
          vertical: context.scaleHeight(8),
        ),
        leading: CircleAvatar(
          radius: context.scale(22),
          backgroundColor: context.colors.primary.withValues(alpha: 0.1),
          backgroundImage: student.profileImageUrl.isNotEmpty
              ? NetworkImage(student.profileImageUrl)
              : null,
          child: student.profileImageUrl.isEmpty
              ? Text(
                  student.name[0],
                  style: TextStyle(
                    color: context.colors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: context.scaleFont(18),
                  ),
                )
              : null,
        ),
        title: Text(
          student.name,
          style: TextStyle(
            fontSize: context.scaleFont(16),
            fontWeight: FontWeight.w600,
            color: context.colors.textPrimary,
          ),
        ),
        subtitle: Text(
          'Roll No: ${student.rollNo} • ${student.className}-${student.section}',
          style: TextStyle(
            fontSize: context.scaleFont(13),
            color: context.colors.textSecondary,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: context.scale(16),
          color: context.colors.textTertiary,
        ),
      ),
    );
  }
}
