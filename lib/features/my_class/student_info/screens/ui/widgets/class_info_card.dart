import 'package:flutter/material.dart';
import '../../../../../../core/routes/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import '../../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../../cubit/theme_cubit.dart';
import '../../../models/class_info_model.dart';

class ClassInfoCard extends StatelessWidget {
  final ClassInfoModel classInfo;

  const ClassInfoCard({super.key, required this.classInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.scaleHeight(1)),
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
        onTap: () => context.router.push(
          StudentListRoute(
            classId: classInfo.id,
            className: '${classInfo.name} - ${classInfo.sectionName}',
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: context.scale(20),
          vertical: context.scaleHeight(8),
        ),
        title: Text(
          '${classInfo.name} - ${classInfo.sectionName}',
          style: TextStyle(
            fontSize: context.scaleFont(16),
            fontWeight: FontWeight.w500,
            color: context.colors.textPrimary,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: context.scale(18),
          color: context.colors.textTertiary,
        ),
      ),
    );
  }
}
