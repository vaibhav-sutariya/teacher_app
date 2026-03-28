import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class NewAdmissionModel extends Equatable {
  final DateTime date;
  final int admissionCount;
  final Color markerColor;

  const NewAdmissionModel({
    required this.date,
    required this.admissionCount,
    required this.markerColor,
  });

  @override
  List<Object?> get props => [date, admissionCount, markerColor];
}
