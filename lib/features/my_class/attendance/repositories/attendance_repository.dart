import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../models/attendance_model.dart';

/// Attendance repository interface - ready for API integration
abstract interface class AttendanceRepository {
  /// Get attendance data for a student
  /// [studentId] - The student ID
  /// [month] - Optional month to filter by (defaults to current month)
  /// [year] - Optional year to filter by (defaults to current year)
  Future<Either<Failure, AttendanceModel>> getAttendance({
    required String studentId,
    DateTime? month,
    int? year,
  });

  /// Get attendance data for a specific date range
  Future<Either<Failure, AttendanceModel>> getAttendanceByDateRange({
    required String studentId,
    required DateTime startDate,
    required DateTime endDate,
  });
}
