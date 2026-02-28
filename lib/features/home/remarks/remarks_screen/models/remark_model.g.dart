// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remark_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RemarkModel _$RemarkModelFromJson(Map<String, dynamic> json) => _RemarkModel(
  id: json['id'] as String?,
  date: json['date'] as String?,
  category:
      $enumDecodeNullable(_$RemarkCategoryEnumMap, json['category']) ??
      RemarkCategory.dailyRoutine,
  type:
      $enumDecodeNullable(_$RemarkTypeEnumMap, json['type']) ??
      RemarkType.negative,
  severity: $enumDecodeNullable(_$RemarkSeverityEnumMap, json['severity']),
  description: json['description'] as String?,
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$RemarkModelToJson(_RemarkModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'category': _$RemarkCategoryEnumMap[instance.category]!,
      'type': _$RemarkTypeEnumMap[instance.type]!,
      'severity': _$RemarkSeverityEnumMap[instance.severity],
      'description': instance.description,
      'createdAt': instance.createdAt,
    };

const _$RemarkCategoryEnumMap = {
  RemarkCategory.dailyRoutine: 'daily_routine',
  RemarkCategory.behaviour: 'behaviour',
  RemarkCategory.classWork: 'class_work',
};

const _$RemarkTypeEnumMap = {
  RemarkType.positive: 'positive',
  RemarkType.negative: 'negative',
};

const _$RemarkSeverityEnumMap = {
  RemarkSeverity.excellent: 'excellent',
  RemarkSeverity.critical: 'critical',
  RemarkSeverity.normal: 'normal',
};
