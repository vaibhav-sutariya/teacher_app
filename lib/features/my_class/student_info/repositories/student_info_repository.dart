import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../models/class_info_model.dart';
import '../models/student_model.dart';

abstract class StudentInfoRepository {
  Future<Either<Failure, List<ClassInfoModel>>> getClasses();
  Future<Either<Failure, List<StudentModel>>> searchStudents(String query);
  Future<Either<Failure, List<StudentModel>>> getStudentsByClass(String classId);
}

@LazySingleton(as: StudentInfoRepository)
class StudentInfoRepositoryImpl implements StudentInfoRepository {
  @override
  Future<Either<Failure, List<ClassInfoModel>>> getClasses() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      return Right([
        const ClassInfoModel(id: '1', name: 'LITTLE CHAMPS', sectionName: 'JAL', color: Color(0xFF7E57C2)),
        const ClassInfoModel(id: '2', name: 'LITTLE CHAMPS', sectionName: 'VAYU', color: Color(0xFF26A69A)),
        const ClassInfoModel(id: '3', name: 'LITTLE CHAMPS', sectionName: 'AAKASH', color: Color(0xFFEF5350)),
        const ClassInfoModel(id: '4', name: 'LITTLE CHAMPS', sectionName: 'PRITHVI', color: Color(0xFF42A5F5)),
        const ClassInfoModel(id: '5', name: 'LITTLE CHAMPS', sectionName: 'TEJ', color: Color(0xFFFFA726)),
        const ClassInfoModel(id: '6', name: 'JR.KG', sectionName: 'JAL', color: Color(0xFF7E57C2)),
        const ClassInfoModel(id: '7', name: 'JR.KG', sectionName: 'VAYU', color: Color(0xFF26A69A)),
        const ClassInfoModel(id: '8', name: 'JR.KG', sectionName: 'AAKASH', color: Color(0xFFEF5350)),
        const ClassInfoModel(id: '9', name: 'JR.KG', sectionName: 'PRITHVI', color: Color(0xFF42A5F5)),
        const ClassInfoModel(id: '10', name: 'SR.KG', sectionName: 'JAL', color: Color(0xFF7E57C2)),
        const ClassInfoModel(id: '11', name: 'SR.KG', sectionName: 'VAYU', color: Color(0xFF26A69A)),
        const ClassInfoModel(id: '12', name: 'SR.KG', sectionName: 'AAKASH', color: Color(0xFFEF5350)),
        const ClassInfoModel(id: '13', name: 'SR.KG', sectionName: 'PRITHVI', color: Color(0xFF42A5F5)),
      ]);
    } catch (e) {
      return Left(Failure.fromServerError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<StudentModel>>> searchStudents(String query) async {
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      if (query.isEmpty) return const Right([]);
      
      final allStudents = [
        const StudentModel(id: '1', name: 'Vaibhav Sutariya', rollNo: '101', className: '1ST', section: 'JAL', profileImageUrl: ''),
        const StudentModel(id: '2', name: 'Amit Patel', rollNo: '102', className: '1ST', section: 'JAL', profileImageUrl: ''),
        const StudentModel(id: '3', name: 'Sagar Sharma', rollNo: '103', className: '1ST', section: 'VAYU', profileImageUrl: ''),
        const StudentModel(id: '4', name: 'Deepa Gupta', rollNo: '104', className: '2ND', section: 'JAL', profileImageUrl: ''),
        const StudentModel(id: '5', name: 'Hitesh Varma', rollNo: '105', className: '2ND', section: 'VAYU', profileImageUrl: ''),
      ];

      final filtered = allStudents.where((s) => s.name.toLowerCase().contains(query.toLowerCase())).toList();
      return Right(filtered);
    } catch (e) {
      return Left(Failure.fromServerError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<StudentModel>>> getStudentsByClass(String classId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 600));
      // In a real app, this would filter by classId on the server
      final students = [
        const StudentModel(id: '1', name: 'AYALDASANI NISHKA KAPIL', rollNo: '1', className: 'Jr KG', section: 'JAL', profileImageUrl: ''),
        const StudentModel(id: '2', name: 'DESAI SHELVI AJAY', rollNo: '2', className: 'Jr KG', section: 'JAL', profileImageUrl: ''),
        const StudentModel(id: '3', name: 'GOL YANA CHIRAGKUMAR', rollNo: '3', className: 'Jr KG', section: 'JAL', profileImageUrl: ''),
        const StudentModel(id: '4', name: 'GOSAI MISTY JATINGIRI', rollNo: '4', className: 'Jr KG', section: 'JAL', profileImageUrl: ''),
        const StudentModel(id: '5', name: 'JANGADE HAZEL KALPEN', rollNo: '5', className: 'Jr KG', section: 'JAL', profileImageUrl: ''),
        const StudentModel(id: '6', name: 'KRIPLANI KHANISHKA KUNAL', rollNo: '6', className: 'Jr KG', section: 'JAL', profileImageUrl: ''),
        const StudentModel(id: '7', name: 'LUNAGARIA MISHVA KISHAN', rollNo: '7', className: 'Jr KG', section: 'JAL', profileImageUrl: ''),
        const StudentModel(id: '8', name: 'MAHETA KAVYA ARJUN', rollNo: '8', className: 'Jr KG', section: 'JAL', profileImageUrl: ''),
      ];
      return Right(students);
    } catch (e) {
      return Left(Failure.fromServerError(e.toString()));
    }
  }
}
