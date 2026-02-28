import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/widgets/attendance_calendar.dart';

part 'attendance_model.freezed.dart';
part 'attendance_model.g.dart';

/// Attendance data model - ready for API integration
@freezed
abstract class AttendanceModel with _$AttendanceModel {
  const factory AttendanceModel({
    @JsonKey(name: 'studentId') String? studentId,
    @JsonKey(name: 'studentName') String? studentName,
    @JsonKey(name: 'academicYear') String? academicYear,
    @JsonKey(name: 'className') String? className,
    @JsonKey(name: 'totalDays') int? totalDays,
    @JsonKey(name: 'presentDays') int? presentDays,
    @JsonKey(name: 'absentDays') int? absentDays,
    @JsonKey(name: 'overallPercentage') double? overallPercentage,
    @JsonKey(name: 'attendanceData') Map<String, String>? attendanceData,
    @JsonKey(name: 'feedbackMessage') String? feedbackMessage,
    @JsonKey(name: 'classAverage') double? classAverage,
  }) = _AttendanceModel;

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceModelFromJson(json);
}

/// Extension to convert API data to calendar format
extension AttendanceModelExtension on AttendanceModel {
  /// Converts attendance data from API format to calendar format
  Map<DateTime, AttendanceStatus> getCalendarData() {
    final calendarData = <DateTime, AttendanceStatus>{};
    
    if (attendanceData == null) return calendarData;

    attendanceData!.forEach((dateString, statusString) {
      try {
        final parsedDate = DateTime.parse(dateString);
        // Normalize date to only include year, month, day (remove time component)
        final date = DateTime(parsedDate.year, parsedDate.month, parsedDate.day);
        final status = _parseStatus(statusString);
        calendarData[date] = status;
      } catch (e) {
        // Skip invalid dates
      }
    });

    return calendarData;
  }

  AttendanceStatus _parseStatus(String status) {
    switch (status.toUpperCase()) {
      case 'PRESENT':
      case 'P':
        return AttendanceStatus.present;
      case 'ABSENT':
      case 'A':
        return AttendanceStatus.absent;
      case 'HOLIDAY':
      case 'H':
        return AttendanceStatus.holiday;
      default:
        return AttendanceStatus.notMarked;
    }
  }
}
