import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../models/assignment_model.dart';

abstract class AssignmentRepository {
  Future<Either<Failure, List<AssignmentModel>>> getAssignments();
  Future<Either<Failure, Unit>> addAssignment(AssignmentModel assignment);
}

@LazySingleton(as: AssignmentRepository)
class AssignmentRepositoryImpl implements AssignmentRepository {
  @override
  Future<Either<Failure, List<AssignmentModel>>> getAssignments() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      return Right(AssignmentModel.getMockData());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> addAssignment(AssignmentModel assignment) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      return const Right(unit);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
