import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ClassInfoModel extends Equatable {
  final String id;
  final String name;
  final String sectionName;
  final Color color;

  const ClassInfoModel({
    required this.id,
    required this.name,
    required this.sectionName,
    required this.color,
  });

  @override
  List<Object?> get props => [id, name, sectionName, color];
}
