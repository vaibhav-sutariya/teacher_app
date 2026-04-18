import 'package:equatable/equatable.dart';

enum AttendanceStatus { present, absent, onLeave }

class StaffAttendanceRecord extends Equatable {
  final String id;
  final String name;
  final String designation;
  final AttendanceStatus status;
  final String? profileImage;

  const StaffAttendanceRecord({
    required this.id,
    required this.name,
    required this.designation,
    required this.status,
    this.profileImage,
  });

  @override
  List<Object?> get props => [id, name, designation, status, profileImage];
}

class StaffAttendanceSummary extends Equatable {
  final DateTime date;
  final int totalStaff;
  final int presentCount;
  final int absentCount;
  final int onLeaveCount;

  const StaffAttendanceSummary({
    required this.date,
    required this.totalStaff,
    required this.presentCount,
    required this.absentCount,
    required this.onLeaveCount,
  });

  double get presentPercentage => (presentCount / totalStaff) * 100;

  @override
  List<Object?> get props => [date, totalStaff, presentCount, absentCount, onLeaveCount];

  static StaffAttendanceSummary getMock(DateTime date) {
    // Deterministic mock data based on month/day for testing
    final day = date.day;
    return StaffAttendanceSummary(
      date: date,
      totalStaff: 104,
      presentCount: 97 - (day % 5),
      absentCount: 7 + (day % 3),
      onLeaveCount: day % 4,
    );
  }

  static List<StaffAttendanceSummary> getMonthlyMock(DateTime month) {
    final lastDay = DateTime(month.year, month.month + 1, 0).day;
    return List.generate(lastDay, (index) {
      final date = DateTime(month.year, month.month, index + 1);
      return getMock(date);
    }).reversed.toList(); // Newest first
  }

  static List<StaffAttendanceRecord> getMockRecords() {
    return const [
      StaffAttendanceRecord(
        id: '1',
        name: 'John Doe',
        designation: 'Mathematics Teacher',
        status: AttendanceStatus.present,
      ),
      StaffAttendanceRecord(
        id: '2',
        name: 'Sarah Smith',
        designation: 'English HOD',
        status: AttendanceStatus.onLeave,
      ),
      StaffAttendanceRecord(
        id: '3',
        name: 'Michael Brown',
        designation: 'Physical Education',
        status: AttendanceStatus.absent,
      ),
    ];
  }
}
