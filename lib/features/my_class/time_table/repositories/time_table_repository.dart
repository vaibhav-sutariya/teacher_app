import 'package:injectable/injectable.dart';
import '../models/time_table_model.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';

abstract class TimeTableRepository {
  Future<Either<Failure, List<TimeTableModel>>> getTimeTables();
  Future<Either<Failure, Unit>> addTimeTable(TimeTableModel timetable);
}

@LazySingleton(as: TimeTableRepository)
class TimeTableRepositoryImpl implements TimeTableRepository {
  @override
  Future<Either<Failure, List<TimeTableModel>>> getTimeTables() async {
    try {
      // Mock data based on the screenshot provided by user
      final mockData = [
        const TimeTableModel(
          id: '1',
          className: 'Sr.KG',
          divisionName: 'VAYU',
          classTeacherName: 'ANUPAMA PRAJAPATI',
          pdfUrl: 'https://www.aeee.in/wp-content/uploads/2020/08/Sample-pdf.pdf',
          type: 'VAYU',
        ),
        const TimeTableModel(
          id: '2',
          className: 'Sr.KG',
          divisionName: 'AAKASH',
          classTeacherName: 'VRUSHALI BRATT',
          pdfUrl: 'https://www.aeee.in/wp-content/uploads/2020/08/Sample-pdf.pdf',
          type: 'AAKASH',
        ),
        const TimeTableModel(
          id: '3',
          className: 'Sr.KG',
          divisionName: 'PRITHVI',
          classTeacherName: 'BALSINGER BAKIR BHARDWAJ',
          pdfUrl: 'https://www.aeee.in/wp-content/uploads/2020/08/Sample-pdf.pdf',
          type: 'PRITHVI',
        ),
        const TimeTableModel(
          id: '4',
          className: '1st',
          divisionName: 'JAL',
          classTeacherName: 'SHITAL KHAMAR',
          pdfUrl: 'https://www.aeee.in/wp-content/uploads/2020/08/Sample-pdf.pdf',
          type: 'JAL',
        ),
        const TimeTableModel(
          id: '5',
          className: '1st',
          divisionName: 'VAYU',
          classTeacherName: 'SHILPA KOTHEKAR',
          pdfUrl: 'https://www.aeee.in/wp-content/uploads/2020/08/Sample-pdf.pdf',
          type: 'VAYU',
        ),
      ];

      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      return Right(mockData);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> addTimeTable(TimeTableModel timetable) async {
    try {
      // Simulate adding to a database
      await Future.delayed(const Duration(seconds: 1));
      return const Right(unit);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
