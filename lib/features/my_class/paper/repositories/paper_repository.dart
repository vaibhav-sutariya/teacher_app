import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../models/paper_model.dart';

abstract class PaperRepository {
  Future<Either<Failure, List<PaperModel>>> getPapers();
  Future<Either<Failure, void>> addPaper(PaperModel paper);
}

@LazySingleton(as: PaperRepository)
class PaperRepositoryImpl implements PaperRepository {
  @override
  Future<Either<Failure, List<PaperModel>>> getPapers() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      return Right(PaperModel.getMockData());
    } catch (e) {
      return Left(Failure.fromServerError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addPaper(PaperModel paper) async {
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      return const Right(null);
    } catch (e) {
      return Left(Failure.fromServerError(e.toString()));
    }
  }
}
