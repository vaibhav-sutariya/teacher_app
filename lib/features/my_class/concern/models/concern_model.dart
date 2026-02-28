import 'package:flutter/material.dart';

enum ConcernStatus { open, inProcess, closed }

class ConcernModel {
  final String id;
  final String ticketNumber;
  final String title;
  final String department;
  final DateTime date;
  final ConcernStatus status;
  final String? description;

  const ConcernModel({
    required this.id,
    required this.ticketNumber,
    required this.title,
    required this.department,
    required this.date,
    required this.status,
    this.description,
  });

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

  static List<ConcernModel> getMockData() {
    return [
      ConcernModel(
        id: '1',
        ticketNumber: '#TKT-4920',
        title: 'Issue with library access',
        description:
            'I am unable to access the digital library with my student credentials. It shows an error "User not found". Please resolve this as I need it for my assignments.',
        department: 'Academic Affairs',
        date: DateTime(2024, 10, 24, 10, 30),
        status: ConcernStatus.open,
      ),
      ConcernModel(
        id: '2',
        ticketNumber: '#TKT-4921',
        title: 'Grade appeal - Math 101',
        description:
            'I would like to appeal my grade for the Math 101 midterm exam. I believe there was a calculation error in question 3.',
        department: 'Academic Affairs',
        date: DateTime(2024, 10, 23, 14, 15),
        status: ConcernStatus.open,
      ),
      ConcernModel(
        id: '3',
        ticketNumber: '#TKT-4899',
        title: 'Hostel Wi-Fi Connectivity',
        description:
            'The Wi-Fi signal in Block B, 2nd floor is very weak. We are unable to attend online classes properly.',
        department: 'Facilities',
        date: DateTime(2024, 10, 22, 9, 0),
        status: ConcernStatus.open,
      ),
      ConcernModel(
        id: '4',
        ticketNumber: '#TKT-4850',
        title: 'Tuition Fee Receipt Not Issued',
        description:
            'I have paid the tuition fee for the current semester on 15th Oct, but haven\'t received the receipt yet.',
        department: 'Finance',
        date: DateTime(2024, 10, 20, 11, 45),
        status: ConcernStatus.open,
      ),
      ConcernModel(
        id: '5',
        ticketNumber: '#TKT-4500',
        title: 'Canteen Food Quality',
        description:
            'The quality of food served in the canteen has degraded over the last week. Please look into this.',
        department: 'Facilities',
        date: DateTime(2024, 10, 18, 13, 0),
        status: ConcernStatus.inProcess,
      ),
      ConcernModel(
        id: '6',
        ticketNumber: '#TKT-4100',
        title: 'Request for Leave',
        description:
            'I need to apply for leave for 2 days due to a family emergency.',
        department: 'Administration',
        date: DateTime(2024, 10, 10, 10, 0),
        status: ConcernStatus.closed,
      ),
    ];
  }
}
