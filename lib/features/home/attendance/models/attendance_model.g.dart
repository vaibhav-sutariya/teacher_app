// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AttendanceModel _$AttendanceModelFromJson(Map<String, dynamic> json) =>
    _AttendanceModel(
      studentId: json['studentId'] as String?,
      studentName: json['studentName'] as String?,
      academicYear: json['academicYear'] as String?,
      className: json['className'] as String?,
      totalDays: (json['totalDays'] as num?)?.toInt(),
      presentDays: (json['presentDays'] as num?)?.toInt(),
      absentDays: (json['absentDays'] as num?)?.toInt(),
      overallPercentage: (json['overallPercentage'] as num?)?.toDouble(),
      attendanceData: (json['attendanceData'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      feedbackMessage: json['feedbackMessage'] as String?,
      classAverage: (json['classAverage'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$AttendanceModelToJson(_AttendanceModel instance) =>
    <String, dynamic>{
      'studentId': instance.studentId,
      'studentName': instance.studentName,
      'academicYear': instance.academicYear,
      'className': instance.className,
      'totalDays': instance.totalDays,
      'presentDays': instance.presentDays,
      'absentDays': instance.absentDays,
      'overallPercentage': instance.overallPercentage,
      'attendanceData': instance.attendanceData,
      'feedbackMessage': instance.feedbackMessage,
      'classAverage': instance.classAverage,
    };
