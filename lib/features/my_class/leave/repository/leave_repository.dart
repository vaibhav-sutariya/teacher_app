import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../models/leave_model.dart';

/// Leave repository interface - ready for API integration
/// Currently returns mock data, can be easily replaced with API implementation
abstract interface class LeaveRepository {
  /// Get all leaves for a student
  /// [studentId] - The student ID
  /// [status] - Optional filter by status ('approved', 'pending', 'rejected')
  Future<Either<Failure, List<LeaveModel>>> getLeaves({
    required String studentId,
    String? status,
  });

  /// Apply for a new leave
  /// Returns the created leave model
  Future<Either<Failure, LeaveModel>> applyLeave({
    required String studentId,
    required DateTime startDate,
    required DateTime endDate,
    required String reason,
  });

  /// Cancel a leave request
  Future<Either<Failure, void>> cancelLeave({required String leaveId});
}
