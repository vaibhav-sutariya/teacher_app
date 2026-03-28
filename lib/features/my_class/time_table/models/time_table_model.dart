import 'package:equatable/equatable.dart';

class TimeTableModel extends Equatable {
  final String id;
  final String className;
  final String divisionName;
  final String classTeacherName;
  final String pdfUrl;
  final String? type;

  const TimeTableModel({
    required this.id,
    required this.className,
    required this.divisionName,
    required this.classTeacherName,
    required this.pdfUrl,
    this.type,
  });

  factory TimeTableModel.fromJson(Map<String, dynamic> json) {
    return TimeTableModel(
      id: json['id'] as String,
      className: json['className'] as String,
      divisionName: json['divisionName'] as String,
      classTeacherName: json['classTeacherName'] as String,
      pdfUrl: json['pdfUrl'] as String,
      type: json['type'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'className': className,
      'divisionName': divisionName,
      'classTeacherName': classTeacherName,
      'pdfUrl': pdfUrl,
      'type': type,
    };
  }

  @override
  List<Object?> get props => [
        id,
        className,
        divisionName,
        classTeacherName,
        pdfUrl,
        type,
      ];
}
