import 'package:fpdart/fpdart.dart';

import '../../../../../core/error/failures.dart';
import '../models/leave_detail_model.dart';

/// Leave detail repository interface - ready for API integration
/// Currently returns mock data, can be easily replaced with API implementation
abstract interface class LeaveDetailRepository {
  /// Get detailed information about a specific leave
  /// [leaveId] - The leave ID
  Future<Either<Failure, LeaveDetailModel>> getLeaveDetail({
    required String leaveId,
  });
}
