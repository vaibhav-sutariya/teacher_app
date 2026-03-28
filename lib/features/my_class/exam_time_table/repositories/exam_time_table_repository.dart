import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../models/exam_time_table_model.dart';

abstract class ExamTimeTableRepository {
  Future<Either<Failure, List<ExamTimeTableModel>>> getExamTimeTables();
  Future<Either<Failure, void>> addExamTimeTable(ExamTimeTableModel timetable);
}

@LazySingleton(as: ExamTimeTableRepository)
class ExamTimeTableRepositoryImpl implements ExamTimeTableRepository {
  @override
  Future<Either<Failure, List<ExamTimeTableModel>>> getExamTimeTables() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      return Right(ExamTimeTableModel.getMockData());
    } catch (e) {
      return Left(Failure.fromServerError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addExamTimeTable(ExamTimeTableModel timetable) async {
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      return const Right(null);
    } catch (e) {
      return Left(Failure.fromServerError(e.toString()));
    }
  }
}
