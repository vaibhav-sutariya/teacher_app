import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../models/syllabus_model.dart';

abstract class SyllabusRepository {
  Future<Either<Failure, List<SyllabusModel>>> getSyllabus();
  Future<Either<Failure, void>> addSyllabus(SyllabusModel syllabus);
}

@LazySingleton(as: SyllabusRepository)
class SyllabusRepositoryImpl implements SyllabusRepository {
  @override
  Future<Either<Failure, List<SyllabusModel>>> getSyllabus() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      return Right(SyllabusModel.getMockData());
    } catch (e) {
      return Left(Failure.fromServerError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addSyllabus(SyllabusModel syllabus) async {
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      return const Right(null);
    } catch (e) {
      return Left(Failure.fromServerError(e.toString()));
    }
  }
}
