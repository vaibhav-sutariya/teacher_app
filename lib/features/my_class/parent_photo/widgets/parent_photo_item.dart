import 'package:flutter/material.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../cubit/theme_cubit.dart';
import '../models/parent_list_model.dart';

class ParentPhotoItem extends StatelessWidget {
  final ParentListModel parent;
  final VoidCallback onTap;

  const ParentPhotoItem({
    super.key,
    required this.parent,
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
            // Parent Photo
            Hero(
              tag: 'parent_photo_${parent.id}',
              child: Container(
                width: context.scale(55),
                height: context.scale(55),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: parent.photoUrl != null
                      ? DecorationImage(
                          image: NetworkImage(parent.photoUrl!),
                          fit: BoxFit.cover,
                        )
                      : null,
                  color: Colors.grey.shade200,
                ),
                child: parent.photoUrl == null
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
                    parent.parentName,
                    style: TextStyle(
                      fontSize: context.scaleFont(15),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(4)),
                  Text(
                    'Student: ${parent.studentName}',
                    style: TextStyle(
                      fontSize: context.scaleFont(14),
                      fontWeight: FontWeight.w500,
                      color: context.colors.textPrimary,
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(2)),
                  Text(
                    'Class: ${parent.className} | Roll No: ${parent.rollNo}',
                    style: TextStyle(
                      fontSize: context.scaleFont(13),
                      color: context.colors.textSecondary,
                    ),
                  ),
                  if (parent.isUploaded) ...[
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
