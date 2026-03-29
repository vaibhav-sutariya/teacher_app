import 'package:equatable/equatable.dart';

enum StaffHistoryStatus { present, absent, weekOff, leave, holiday }

class StaffAttendanceHistoryLog extends Equatable {
  final DateTime date;
  final StaffHistoryStatus status;
  final String? inTime;
  final String? outTime;

  const StaffAttendanceHistoryLog({
    required this.date,
    required this.status,
    this.inTime,
    this.outTime,
  });

  @override
  List<Object?> get props => [date, status, inTime, outTime];

  static List<StaffAttendanceHistoryLog> getMockLogs(DateTime month) {
    // Generate logs for the entire month
    final lastDay = DateTime(month.year, month.month + 1, 0).day;
    return List.generate(lastDay, (index) {
      final date = DateTime(month.year, month.month, index + 1);
      final isSunday = date.weekday == DateTime.sunday;
      
      if (isSunday) {
        return StaffAttendanceHistoryLog(
          date: date,
          status: StaffHistoryStatus.weekOff,
        );
      }

      // Randomly assign statuses for mock
      final val = (index + 3) % 15;
      if (val == 0) {
        return StaffAttendanceHistoryLog(
          date: date,
          status: StaffHistoryStatus.absent,
        );
      } else if (val == 7) {
        return StaffAttendanceHistoryLog(
          date: date,
          status: StaffHistoryStatus.leave,
        );
      } else if (val == 12) {
        return StaffAttendanceHistoryLog(
          date: date,
          status: StaffHistoryStatus.holiday,
        );
      }

      return StaffAttendanceHistoryLog(
        date: date,
        status: StaffHistoryStatus.present,
        inTime: '07:31 AM',
        outTime: '03:09 PM',
      );
    });
  }
}
