import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum ConcernStatus { open, inProcess, closed }

class ConcernModel extends Equatable {
  final String id;
  final String ticketNumber;
  final String title;
  final String department;
  final DateTime date;
  final ConcernStatus status;
  final String? description;

  // New fields for Teacher/Resolution
  final String studentName;
  final String studentGrade;
  final String? studentAvatar;
  final String? resolution;
  final DateTime? resolutionDate;
  final List<String> proofImages;

  const ConcernModel({
    required this.id,
    required this.ticketNumber,
    required this.title,
    required this.department,
    required this.date,
    required this.status,
    required this.studentName,
    required this.studentGrade,
    this.description,
    this.studentAvatar,
    this.resolution,
    this.resolutionDate,
    this.proofImages = const [],
  });

  @override
  List<Object?> get props => [
    id,
    ticketNumber,
    title,
    department,
    date,
    status,
    description,
    studentName,
    studentGrade,
    studentAvatar,
    resolution,
    resolutionDate,
    proofImages,
  ];

  Color get statusColor {
    switch (status) {
      case ConcernStatus.open:
        return const Color(0xFFE8F5E9); // Light Green
      case ConcernStatus.inProcess:
        return const Color(0xFFE3F2FD); // Light Blue
      case ConcernStatus.closed:
        return const Color(0xFFFFEBEE); // Light Red
    }
  }

  Color get statusTextColor {
    switch (status) {
      case ConcernStatus.open:
        return const Color(0xFF2E7D32); // Dark Green
      case ConcernStatus.inProcess:
        return const Color(0xFF1565C0); // Dark Blue
      case ConcernStatus.closed:
        return const Color(0xFFC62828); // Dark Red
    }
  }

  String get statusLabel {
    switch (status) {
      case ConcernStatus.open:
        return 'OPEN';
      case ConcernStatus.inProcess:
        return 'IN PROCESS';
      case ConcernStatus.closed:
        return 'CLOSED';
    }
  }

  ConcernModel copyWith({
    ConcernStatus? status,
    String? resolution,
    DateTime? resolutionDate,
    List<String>? proofImages,
  }) {
    return ConcernModel(
      id: id,
      ticketNumber: ticketNumber,
      title: title,
      department: department,
      date: date,
      status: status ?? this.status,
      description: description,
      studentName: studentName,
      studentGrade: studentGrade,
      studentAvatar: studentAvatar,
      resolution: resolution ?? this.resolution,
      resolutionDate: resolutionDate ?? this.resolutionDate,
      proofImages: proofImages ?? this.proofImages,
    );
  }

  static List<ConcernModel> getMockData() {
    return [
      ConcernModel(
        id: '1',
        ticketNumber: '#TKT-4920',
        title: 'Issue with library access',
        description:
            'I am unable to access the digital library with my student credentials. It shows an error "User not found". Please resolve this as I need it for my assignments.',
        department: 'Academic Affairs',
        date: DateTime.now().subtract(const Duration(days: 1)),
        status: ConcernStatus.open,
        studentName: 'Aarav Sharma',
        studentGrade: 'Grade 10-A',
        studentAvatar: 'https://i.pravatar.cc/150?u=aarav',
      ),
      ConcernModel(
        id: '2',
        ticketNumber: '#TKT-4921',
        title: 'Grade appeal - Math 101',
        description:
            'I would like to appeal my grade for the Math 101 midterm exam. I believe there was a calculation error in question 3.',
        department: 'Academic Affairs',
        date: DateTime.now().subtract(const Duration(days: 2)),
        status: ConcernStatus.open,
        studentName: 'Ishani Patel',
        studentGrade: 'Grade 9-B',
        studentAvatar: 'https://i.pravatar.cc/150?u=ishani',
      ),
      ConcernModel(
        id: '3',
        ticketNumber: '#TKT-4899',
        title: 'Hostel Wi-Fi Connectivity',
        description:
            'The Wi-Fi signal in Block B, 2nd floor is very weak. We are unable to attend online classes properly.',
        department: 'Facilities',
        date: DateTime.now().subtract(const Duration(days: 3)),
        status: ConcernStatus.inProcess,
        studentName: 'Vihaan Gupta',
        studentGrade: 'Grade 11-C',
        studentAvatar: 'https://i.pravatar.cc/150?u=vihaan',
      ),
      ConcernModel(
        id: '4',
        ticketNumber: '#TKT-4100',
        title: 'Request for Leave',
        description:
            'I need to apply for leave for 2 days due to a family emergency.',
        department: 'Administration',
        date: DateTime.now().subtract(const Duration(days: 10)),
        status: ConcernStatus.closed,
        studentName: 'Ananya Rao',
        studentGrade: 'Grade 8-A',
        studentAvatar: 'https://i.pravatar.cc/150?u=ananya',
        resolution: 'Leave approved after verifying the emergency details.',
        resolutionDate: DateTime.now().subtract(const Duration(days: 9)),
      ),
    ];
  }
}
