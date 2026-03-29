import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DashboardSettingItem extends Equatable {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final bool isEnabled;

  const DashboardSettingItem({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    this.isEnabled = true,
  });

  DashboardSettingItem copyWith({
    String? id,
    String? title,
    String? description,
    IconData? icon,
    bool? isEnabled,
  }) {
    return DashboardSettingItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }

  @override
  List<Object?> get props => [id, title, description, icon, isEnabled];

  static List<DashboardSettingItem> getDefaultSettings() {
    return [
      const DashboardSettingItem(
        id: '1',
        title: 'Today\'s Timetable',
        description: 'Show upcoming classes and schedules for the day.',
        icon: Icons.schedule_rounded,
        isEnabled: true,
      ),
      const DashboardSettingItem(
        id: '2',
        title: 'Quick Actions',
        description: 'Shortcuts to frequent tasks like Attendance and Marks.',
        icon: Icons.flash_on_rounded,
        isEnabled: true,
      ),
      const DashboardSettingItem(
        id: '3',
        title: 'Pending Approvals',
        description: 'Alerts for awaiting student permissions and leaves.',
        icon: Icons.fact_check_outlined,
        isEnabled: true,
      ),
      const DashboardSettingItem(
        id: '4',
        title: 'Recent Announcements',
        description: 'Important updates and circulars from the school.',
        icon: Icons.campaign_outlined,
        isEnabled: true,
      ),
      const DashboardSettingItem(
        id: '5',
        title: 'Class Attendance Overview',
        description: 'Quick statistics on student presence for today.',
        icon: Icons.pie_chart_outline_rounded,
        isEnabled: false,
      ),
    ];
  }
}
