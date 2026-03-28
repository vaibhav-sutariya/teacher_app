import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../models/holiday_hw_model.dart';

abstract class HolidayHwRepository {
  Future<Either<Failure, List<HolidayHwModel>>> getHolidayHw();
  Future<Either<Failure, void>> addHolidayHw(HolidayHwModel homework);
}

@LazySingleton(as: HolidayHwRepository)
class HolidayHwRepositoryImpl implements HolidayHwRepository {
  @override
  Future<Either<Failure, List<HolidayHwModel>>> getHolidayHw() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      return Right(HolidayHwModel.getMockData());
    } catch (e) {
      return Left(Failure.fromServerError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addHolidayHw(HolidayHwModel homework) async {
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      return const Right(null);
    } catch (e) {
      return Left(Failure.fromServerError(e.toString()));
    }
  }
}
