import 'package:flutter/material.dart';
import '../../../../core/helpers/extensions/responsive_extensions.dart';
import '../models/student_profile_model.dart';

class StudentProfileHeader extends StatelessWidget {
  final StudentProfileModel profile;

  const StudentProfileHeader({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFFFCC00), // Yellow as per screenshot
      padding: EdgeInsets.fromLTRB(
        context.scale(16),
        context.scaleHeight(40),
        context.scale(16),
        context.scaleHeight(24),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(context.scale(3)),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: context.scale(45),
              backgroundImage: NetworkImage(profile.profileImageUrl),
            ),
          ),
          SizedBox(height: context.scaleHeight(12)),
          Text(
            profile.name.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: context.scaleFont(18),
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: context.scaleHeight(4)),
          Text(
            profile.schoolName,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: context.scaleFont(12),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: context.scaleHeight(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ActionButton(
                icon: Icons.person_outline,
                label: 'Father',
                onTap: () {},
              ),
              _ActionButton(
                icon: Icons.person_add_outlined,
                label: 'Mother',
                onTap: () {},
              ),
              _ActionButton(
                icon: Icons.group_outlined,
                label: 'Guardian',
                onTap: () {},
              ),
              _ActionButton(
                icon: Icons.face_outlined,
                label: 'Siblings Info',
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(context.scale(10)),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: const Color(0xFF00ACC1), // Cyan/Blue as per screenshot
              size: context.scale(22),
            ),
          ),
          SizedBox(height: context.scaleHeight(6)),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: context.scaleFont(11),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
