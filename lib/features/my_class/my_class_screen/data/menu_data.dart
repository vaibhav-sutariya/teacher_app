import 'package:flutter/material.dart';

class MenuItemData {
  final IconData icon;
  final String label;
  final Color iconColor;
  final Color backgroundColor;

  const MenuItemData({
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.backgroundColor,
  });
}

class MenuSectionData {
  final String title;
  final List<MenuItemData> items;
  final Color sectionColor; // Kept for reference, though we use white cards now

  const MenuSectionData({
    required this.title,
    required this.items,
    required this.sectionColor,
  });
}

class QuickMenuData {
  static const List<MenuSectionData> sections = [
    MenuSectionData(
      title: 'Academics',
      sectionColor: Color(0xFFE3F2FD),
      items: [
        MenuItemData(
          icon: Icons.check_circle_outline_rounded,
          label: 'Attendance',
          iconColor: Color(0xFF5C6BC0),
          backgroundColor: Color(0xFFE8EAF6),
        ),
        MenuItemData(
          icon: Icons.rate_review_outlined,
          label: 'Remarks',
          iconColor: Color(0xFF26C6DA),
          backgroundColor: Color(0xFFE0F7FA),
        ),
        MenuItemData(
          icon: Icons.home_work_outlined,
          label: 'Homework',
          iconColor: Color(0xFFFF7043),
          backgroundColor: Color(0xFFFBE9E7),
        ),
        MenuItemData(
          icon: Icons.restaurant_menu_rounded,
          label: 'Meal Menu',
          iconColor: Color(0xFF8D6E63),
          backgroundColor: Color(0xFFEFEBE9),
        ),
        MenuItemData(
          icon: Icons.photo_library_outlined,
          label: 'Gallery',
          iconColor: Color(0xFFEC407A),
          backgroundColor: Color(0xFFFCE4EC),
        ),
        MenuItemData(
          icon: Icons.groups_outlined,
          label: 'PTM',
          iconColor: Color(0xFF7E57C2),
          backgroundColor: Color(0xFFEDE7F6),
        ),
        MenuItemData(
          icon: Icons.campaign_outlined,
          label: 'Student Notice',
          iconColor: Color(0xFFFFA726),
          backgroundColor: Color(0xFFFFF3E0),
        ),
        MenuItemData(
          icon: Icons.menu_book_rounded,
          label: 'Subject wise Homework',
          iconColor: Color(0xFFAB47BC),
          backgroundColor: Color(0xFFF3E5F5),
        ),
        MenuItemData(
          icon: Icons.edit_note_rounded,
          label: 'Class Work',
          iconColor: Color(0xFF66BB6A),
          backgroundColor: Color(0xFFE8F5E9),
        ),
        MenuItemData(
          icon: Icons.video_library_outlined,
          label: 'Video Gallery',
          iconColor: Color(0xFFEF5350),
          backgroundColor: Color(0xFFFFEBEE),
        ),
        MenuItemData(
          icon: Icons.directions_bus_outlined,
          label: 'Transport Attendance',
          iconColor: Color(0xFF546E7A),
          backgroundColor: Color(0xFFECEFF1),
        ),
        MenuItemData(
          icon: Icons.report_problem_outlined,
          label: 'Concerns',
          iconColor: Color(0xFF78909C),
          backgroundColor: Color(0xFFECEFF1),
        ),
        MenuItemData(
          icon: Icons.transfer_within_a_station_rounded,
          label: 'View Transport Attendance',
          iconColor: Color(0xFF5C6BC0),
          backgroundColor: Color(0xFFE8EAF6),
        ),
        MenuItemData(
          icon: Icons.door_back_door,
          label: 'Gatepass Details',
          iconColor: Color(0xFFFF7043),
          backgroundColor: Color(0xFFFBE9E7),
        ),
      ],
    ),
    MenuSectionData(
      title: 'Downloads',
      sectionColor: Color(0xFFFFF3E0),
      items: [
        MenuItemData(
          icon: Icons.schedule_rounded,
          label: 'Time Table',
          iconColor: Color(0xFF5C6BC0),
          backgroundColor: Color(0xFFE8EAF6),
        ),
        MenuItemData(
          icon: Icons.assignment_outlined,
          label: 'Assignment',
          iconColor: Color(0xFFFF7043),
          backgroundColor: Color(0xFFFBE9E7),
        ),
        MenuItemData(
          icon: Icons.list_alt_rounded,
          label: 'Syllabus',
          iconColor: Color(0xFFAB47BC),
          backgroundColor: Color(0xFFF3E5F5),
        ),
        MenuItemData(
          icon: Icons.article_outlined,
          label: 'Exam Paper',
          iconColor: Color(0xFFFFA726),
          backgroundColor: Color(0xFFFFF3E0),
        ),
        MenuItemData(
          icon: Icons.beach_access_rounded,
          label: 'Holiday Homework',
          iconColor: Color(0xFFEC407A),
          backgroundColor: Color(0xFFFCE4EC),
        ),
        MenuItemData(
          icon: Icons.calendar_month_rounded,
          label: 'Exam Time Table',
          iconColor: Color(0xFF26C6DA),
          backgroundColor: Color(0xFFE0F7FA),
        ),
      ],
    ),
    MenuSectionData(
      title: 'Analysis',
      sectionColor: Color(0xFFF3E5F5),
      items: [
        MenuItemData(
          icon: Icons.person_outline_rounded,
          label: 'Student Info',
          iconColor: Color(0xFF26C6DA),
          backgroundColor: Color(0xFFE0F7FA),
        ),
        MenuItemData(
          icon: Icons.calendar_today_outlined,
          label: 'Calendar',
          iconColor: Color(0xFFFFA726),
          backgroundColor: Color(0xFFFFF3E0),
        ),
        MenuItemData(
          icon: Icons.cake_outlined,
          label: 'Birthday',
          iconColor: Color(0xFFEC407A),
          backgroundColor: Color(0xFFFCE4EC),
        ),
        MenuItemData(
          icon: Icons.person_add_outlined,
          label: 'New Admission',
          iconColor: Color(0xFF66BB6A),
          backgroundColor: Color(0xFFE8F5E9),
        ),
      ],
    ),
    MenuSectionData(
      title: 'Administration',
      sectionColor: Color(0xFFE8F5E9),
      items: [
        MenuItemData(
          icon: Icons.add_a_photo_outlined,
          label: 'Student Photo Upload',
          iconColor: Color(0xFF1877F2),
          backgroundColor: Color(0xFFE3F2FD),
        ),
        MenuItemData(
          icon: Icons.badge_outlined,
          label: 'Employee Photo',
          iconColor: Color(0xFF7E57C2),
          backgroundColor: Color(0xFFEDE7F6),
        ),
        MenuItemData(
          icon: Icons.family_restroom_outlined,
          label: 'Parent Photo',
          iconColor: Color(0xFFFF7043),
          backgroundColor: Color(0xFFFBE9E7),
        ),
      ],
    ),
  ];
}
