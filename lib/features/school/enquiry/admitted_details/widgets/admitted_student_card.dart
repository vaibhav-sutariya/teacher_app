import 'package:flutter/material.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';
import '../../models/enquiry_student_model.dart';

class AdmittedStudentCard extends StatelessWidget {
  final EnquiryStudentModel student;

  const AdmittedStudentCard({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.scale(16),
        vertical: context.scaleHeight(8),
      ),
      padding: EdgeInsets.all(context.scale(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.scale(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Avatar/Icon
              Container(
                width: context.scale(50),
                height: context.scale(50),
                decoration: BoxDecoration(
                  color: context.colors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  student.gender.toLowerCase() == 'male' ? Icons.face : Icons.face_3,
                  color: context.colors.primary,
                  size: context.scale(30),
                ),
              ),
              SizedBox(width: context.scale(16)),

              // 2. Student Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            student.name,
                            style: TextStyle(
                              fontSize: context.scaleFont(16),
                              fontWeight: FontWeight.bold,
                              color: context.colors.textPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        _StatusBadge(status: student.status),
                      ],
                    ),
                    SizedBox(height: context.scaleHeight(4)),
                    Text(
                      'Fathers Name: ${student.fatherName}',
                      style: TextStyle(
                        fontSize: context.scaleFont(13),
                        color: context.colors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: context.scaleHeight(8)),
                    Row(
                      children: [
                        _InfoChip(label: 'Class: ${student.className}'),
                        SizedBox(width: context.scale(8)),
                        _InfoChip(label: 'Gender: ${student.gender}'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: context.scaleHeight(12)),
          
          // 3. Action Buttons
          const Divider(height: 1),
          SizedBox(height: context.scaleHeight(12)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _ActionButton(
                icon: Icons.call_outlined,
                color: context.colors.success,
                onTap: () {},
              ),
              SizedBox(width: context.scale(12)),
              _ActionButton(
                icon: Icons.message_outlined,
                color: context.colors.primary,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status.toUpperCase()) {
      case 'ADMITTED':
        color = context.colors.success;
        break;
      case 'REGISTRATION':
        color = Colors.blue;
        break;
      default:
        color = context.colors.warning;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.scale(8),
        vertical: context.scaleHeight(4),
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(context.scale(6)),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: context.scaleFont(10),
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  const _InfoChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.scale(8),
        vertical: context.scaleHeight(2),
      ),
      decoration: BoxDecoration(
        color: context.colors.surface200,
        borderRadius: BorderRadius.circular(context.scale(4)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: context.scaleFont(11),
          color: context.colors.textSecondary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(context.scale(8)),
      child: Container(
        padding: EdgeInsets.all(context.scale(8)),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(context.scale(8)),
        ),
        child: Icon(icon, color: color, size: context.scale(20)),
      ),
    );
  }
}
