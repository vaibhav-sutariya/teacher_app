import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ServiceModel extends Equatable {
  final String id;
  final String label;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  const ServiceModel({
    required this.id,
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
  });

  @override
  List<Object?> get props => [id, label, icon, iconColor, backgroundColor];

  static List<ServiceModel> getServiceItems() {
    return [
      const ServiceModel(
        id: 'leave',
        label: 'Leave',
        icon: Icons.event_note_outlined,
        iconColor: Color(0xFFE91E63),
        backgroundColor: Color(0xFFFCE4EC),
      ),
      const ServiceModel(
        id: 'approvals',
        label: 'Approvals',
        icon: Icons.fact_check_outlined,
        iconColor: Color(0xFF4CAF50),
        backgroundColor: Color(0xFFE8F5E9),
      ),
      const ServiceModel(
        id: 'manual_punch',
        label: 'Manual Punch',
        icon: Icons.fingerprint_outlined,
        iconColor: Color(0xFF2196F3),
        backgroundColor: Color(0xFFE3F2FD),
      ),
      const ServiceModel(
        id: 'approve_punch',
        label: 'Approve/Reject Manual Punch',
        icon: Icons.how_to_reg_outlined,
        iconColor: Color(0xFFFF9800),
        backgroundColor: Color(0xFFFFF3E0),
      ),
      const ServiceModel(
        id: 'announcements',
        label: 'Announcements',
        icon: Icons.campaign_outlined,
        iconColor: Color(0xFF9C27B0),
        backgroundColor: Color(0xFFF3E5F5),
      ),
      const ServiceModel(
        id: 'performance',
        label: 'Performance',
        icon: Icons.speed_outlined,
        iconColor: Color(0xFF00BCD4),
        backgroundColor: Color(0xFFE0F7FA),
      ),
      const ServiceModel(
        id: 'student_leave',
        label: 'Student Leave',
        icon: Icons.person_off_outlined,
        iconColor: Color(0xFFFF5722),
        backgroundColor: Color(0xFFFBE9E7),
      ),
    ];
  }
}
