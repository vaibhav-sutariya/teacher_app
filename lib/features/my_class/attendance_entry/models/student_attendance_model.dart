import 'package:equatable/equatable.dart';

enum AttendanceStatusEnum { present, absent, notMarked }

class StudentAttendanceModel extends Equatable {
  final String studentId;
  final String name;
  final String rollNoString;
  final int rollNumber;
  final String imageUrl;
  final AttendanceStatusEnum status;
  final String specialStatus; // Default 'S'

  const StudentAttendanceModel({
    required this.studentId,
    required this.name,
    required this.rollNoString,
    required this.rollNumber,
    required this.imageUrl,
    this.status = AttendanceStatusEnum.notMarked,
    this.specialStatus = 'S',
  });

  StudentAttendanceModel copyWith({
    String? studentId,
    String? name,
    String? rollNoString,
    int? rollNumber,
    String? imageUrl,
    AttendanceStatusEnum? status,
    String? specialStatus,
  }) {
    return StudentAttendanceModel(
      studentId: studentId ?? this.studentId,
      name: name ?? this.name,
      rollNoString: rollNoString ?? this.rollNoString,
      rollNumber: rollNumber ?? this.rollNumber,
      imageUrl: imageUrl ?? this.imageUrl,
      status: status ?? this.status,
      specialStatus: specialStatus ?? this.specialStatus,
    );
  }

  @override
  List<Object?> get props => [
    studentId,
    name,
    rollNoString,
    rollNumber,
    imageUrl,
    status,
    specialStatus,
  ];
}
