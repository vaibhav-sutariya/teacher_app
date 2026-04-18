import 'package:flutter/material.dart';
import '../../../../../../core/helpers/extensions/responsive_extensions.dart';
import '../../../../../../cubit/theme_cubit.dart';
import '../../../models/birthday_member_model.dart';

class BirthdayMemberCard extends StatelessWidget {
  final BirthdayMemberModel member;

  const BirthdayMemberCard({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.scale(16),
        vertical: context.scaleHeight(6),
      ),
      padding: EdgeInsets.all(context.scale(12)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.scale(12)),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Profile Image
          Container(
            width: context.scale(48),
            height: context.scale(48),
            decoration: BoxDecoration(
              color: context.colors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person,
              color: context.colors.primary,
              size: context.scale(24),
            ),
          ),
          SizedBox(width: context.scale(12)),
          // Member Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.name,
                  style: TextStyle(
                    fontSize: context.scaleFont(15),
                    fontWeight: FontWeight.w600,
                    color: context.colors.textPrimary,
                  ),
                ),
                Text(
                  member.subTitle,
                  style: TextStyle(
                    fontSize: context.scaleFont(13),
                    color: context.colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          // Birthday Icon / Action
          IconButton(
            icon: Icon(
              Icons.cake_outlined,
              color: Colors.pink.shade300,
              size: context.scale(24),
            ),
            onPressed: () {
              // Wish logic could go here
            },
          ),
        ],
      ),
    );
  }
}
