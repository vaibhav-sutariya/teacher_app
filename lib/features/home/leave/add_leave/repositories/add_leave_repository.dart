import 'package:fpdart/fpdart.dart';

import '../../../../../../core/error/failures.dart';
import '../models/add_leave_request_model.dart';

abstract interface class AddLeaveRepository {
  Future<Either<Failure, void>> applyLeave(AddLeaveRequestModel request);
}

class AddLeaveRepositoryImpl implements AddLeaveRepository {
  @override
  Future<Either<Failure, void>> applyLeave(AddLeaveRequestModel request) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    return const Right(null);
  }
}
