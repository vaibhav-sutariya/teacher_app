import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:teachers_app/core/helpers/extensions/responsive_extensions.dart';
import 'package:teachers_app/cubit/theme_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:teachers_app/core/routes/app_router.gr.dart';
import '../models/staff_model.dart';

class StaffSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const StaffSearchBar({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.scale(16),
        vertical: context.scaleHeight(12),
      ),
      height: context.scaleHeight(44),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9), // Very light blue-grey background
        borderRadius: BorderRadius.circular(context.scale(25)),
      ),
      child: TextField(
        onChanged: onChanged,
        style: TextStyle(
          fontSize: context.scaleFont(14),
          color: Colors.grey.shade800,
        ),
        cursorColor: context.colors.primary,
        decoration: InputDecoration(
          hintText: 'Search Employee',
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
            fontSize: context.scaleFont(14),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey.shade400,
            size: context.scale(18),
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            vertical: context.scaleHeight(10),
            horizontal: context.scale(12),
          ),
        ),
      ),
    );
  }
}

class StaffListTile extends StatelessWidget {
  final StaffMember staff;

  const StaffListTile({super.key, required this.staff});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.router.push(StaffAttendanceHistoryRoute(staff: staff)),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.scale(16),
            vertical: context.scaleHeight(4),
          ),
          child: Row(
            children: [
              // 1. Profile Image
              CircleAvatar(
                radius: context.scale(22),
                backgroundColor: context.colors.surface200,
                backgroundImage: staff.profileImage != null
                    ? CachedNetworkImageProvider(staff.profileImage!)
                    : null,
                child: staff.profileImage == null
                    ? Icon(Icons.person, color: Colors.grey.shade400, size: 24)
                    : null,
              ),

              SizedBox(width: context.scale(16)),

              // 2. Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      staff.name.toUpperCase(),
                      style: TextStyle(
                        fontSize: context.scaleFont(14),
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: context.scaleHeight(2)),
                    Text(
                      staff.designation.toUpperCase(),
                      style: TextStyle(
                        fontSize: context.scaleFont(11),
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade400,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AlphabetIndexBar extends StatelessWidget {
  final List<String> alphabets;
  final ValueChanged<String> onSelected;

  const AlphabetIndexBar({
    super.key,
    required this.alphabets,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.scale(30),
      alignment: Alignment.center,
      child: ListView.builder(
        itemCount: alphabets.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => onSelected(alphabets[index]),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: context.scaleHeight(2)),
              child: Text(
                alphabets[index],
                style: TextStyle(
                  fontSize: context.scaleFont(12),
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      ),
    );
  }
}
