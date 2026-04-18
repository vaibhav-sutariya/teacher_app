import 'package:equatable/equatable.dart';

enum LeaveStatus { pending, approved, rejected }

class LeaveApplication extends Equatable {
  final String id;
  final String type;
  final DateTime fromDate;
  final DateTime toDate;
  final LeaveStatus status;
  final String reason;
  final DateTime appliedDate;

  const LeaveApplication({
    required this.id,
    required this.type,
    required this.fromDate,
    required this.toDate,
    required this.status,
    required this.reason,
    required this.appliedDate,
  });

  @override
  List<Object?> get props => [id, type, fromDate, toDate, status, reason, appliedDate];

  static List<LeaveApplication> getMockLeaves() {
    final now = DateTime.now();
    return [
      LeaveApplication(
        id: '1',
        type: 'Casual Leave',
        fromDate: now.subtract(const Duration(days: 10)),
        toDate: now.subtract(const Duration(days: 9)),
        status: LeaveStatus.approved,
        reason: 'Family function',
        appliedDate: now.subtract(const Duration(days: 15)),
      ),
      LeaveApplication(
        id: '2',
        type: 'Sick Leave',
        fromDate: now.add(const Duration(days: 5)),
        toDate: now.add(const Duration(days: 6)),
        status: LeaveStatus.pending,
        reason: 'Medical checkup',
        appliedDate: now.subtract(const Duration(days: 1)),
      ),
      LeaveApplication(
        id: '3',
        type: 'Earned Leave',
        fromDate: now.subtract(const Duration(days: 30)),
        toDate: now.subtract(const Duration(days: 28)),
        status: LeaveStatus.rejected,
        reason: 'Personal work',
        appliedDate: now.subtract(const Duration(days: 35)),
      ),
    ];
  }
}

class HolidayModel extends Equatable {
  final String id;
  final String title;
  final DateTime date;
  final String description;

  const HolidayModel({
    required this.id,
    required this.title,
    required this.date,
    required this.description,
  });

  @override
  List<Object?> get props => [id, title, date, description];

  static List<HolidayModel> getMockHolidays() {
    final now = DateTime.now();
    return [
      HolidayModel(
        id: '1',
        title: 'Independence Day',
        date: DateTime(now.year, 8, 15),
        description: 'National Holiday',
      ),
      HolidayModel(
        id: '2',
        title: 'Ganesh Chaturthi',
        date: DateTime(now.year, 9, 7),
        description: 'Festival Holiday',
      ),
      HolidayModel(
        id: '3',
        title: 'Gandhi Jayanti',
        date: DateTime(now.year, 10, 2),
        description: 'National Holiday',
      ),
      HolidayModel(
        id: '4',
        title: 'Diwali',
        date: DateTime(now.year, 11, 1),
        description: 'Festival Holiday',
      ),
    ];
  }
}

class LeaveBalanceModel extends Equatable {
  final String type;
  final double total;
  final double used;
  final double remaining;

  const LeaveBalanceModel({
    required this.type,
    required this.total,
    required this.used,
    required this.remaining,
  });

  @override
  List<Object?> get props => [type, total, used, remaining];

  static List<LeaveBalanceModel> getMockBalances() {
    return [
      const LeaveBalanceModel(type: 'Casual Leave', total: 12, used: 4, remaining: 8),
      const LeaveBalanceModel(type: 'Sick Leave', total: 10, used: 2, remaining: 8),
      const LeaveBalanceModel(type: 'Earned Leave', total: 15, used: 5, remaining: 10),
      const LeaveBalanceModel(type: 'Maternity Leave', total: 180, used: 0, remaining: 180),
    ];
  }
}
