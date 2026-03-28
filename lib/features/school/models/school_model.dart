import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SchoolModuleModel extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String? badgeText;
  final bool showArrow;

  const SchoolModuleModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    this.badgeText,
    this.showArrow = true,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        subtitle,
        icon,
        iconColor,
        backgroundColor,
        badgeText,
        showArrow,
      ];
}

class SchoolManagementModel extends Equatable {
  final List<SchoolModuleModel> modules;

  const SchoolManagementModel({required this.modules});

  @override
  List<Object?> get props => [modules];

  static SchoolManagementModel getMockModules() {
    return const SchoolManagementModel(
      modules: [
        SchoolModuleModel(
          id: 'fees',
          title: 'Fees',
          subtitle: 'Collection and reconciliation',
          icon: Icons.account_balance_wallet_outlined,
          iconColor: Color(0xFF2E7D32), // Green
          backgroundColor: Color(0xFFE8F5E9),
        ),
        SchoolModuleModel(
          id: 'staff_attendance',
          title: 'Staff Attendance',
          subtitle: 'Daily logs and leave management',
          icon: Icons.how_to_reg_outlined,
          iconColor: Color(0xFF1976D2), // Blue
          backgroundColor: Color(0xFFE3F2FD),
        ),
        SchoolModuleModel(
          id: 'staff_details',
          title: 'Staff Details',
          subtitle: 'Employee profiles and contact',
          icon: Icons.badge_outlined,
          iconColor: Color(0xFF7B1FA2), // Purple
          backgroundColor: Color(0xFFF3E5F5),
        ),
        SchoolModuleModel(
          id: 'notice',
          title: 'Notice & Circulars',
          subtitle: 'Broadcast announcements',
          icon: Icons.campaign_outlined,
          iconColor: Color(0xFFF57C00), // Orange
          backgroundColor: Color(0xFFFFF3E0),
        ),
        SchoolModuleModel(
          id: 'enquiry',
          title: 'Enquiry',
          subtitle: 'Admission leads and queries',
          icon: Icons.help_outline_rounded,
          iconColor: Color(0xFF00796B), // Teal
          backgroundColor: Color(0xFFE0F2F1),
        ),
        SchoolModuleModel(
          id: 'strength',
          title: 'School Strength',
          subtitle: 'Live count per class',
          icon: Icons.people_outline_rounded,
          iconColor: Color(0xFF455A64), // Blue Grey
          backgroundColor: Color(0xFFECEFF1),
          badgeText: 'ACTIVE',
          showArrow: false,
        ),
        SchoolModuleModel(
          id: 'bus',
          title: 'Bus Tracking',
          subtitle: 'Real-time GPS monitoring',
          icon: Icons.directions_bus_outlined,
          iconColor: Color(0xFF388E3C), // Green
          backgroundColor: Color(0xFFE8F5E9),
        ),
      ],
    );
  }
}
