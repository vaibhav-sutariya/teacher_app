// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActivityLogItem _$ActivityLogItemFromJson(Map<String, dynamic> json) =>
    _ActivityLogItem(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      type: $enumDecode(_$ActivityTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$ActivityLogItemToJson(_ActivityLogItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'subtitle': instance.subtitle,
      'timestamp': instance.timestamp.toIso8601String(),
      'type': _$ActivityTypeEnumMap[instance.type]!,
    };

const _$ActivityTypeEnumMap = {
  ActivityType.approved: 'approved',
  ActivityType.submitted: 'submitted',
  ActivityType.rejected: 'rejected',
};

_LeaveDetailModel _$LeaveDetailModelFromJson(Map<String, dynamic> json) =>
    _LeaveDetailModel(
      id: json['id'] as String,
      status: json['status'] as String,
      approvedBy: json['approvedBy'] as String?,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      days: (json['days'] as num).toInt(),
      approvalDate: json['approvalDate'] == null
          ? null
          : DateTime.parse(json['approvalDate'] as String),
      requestDate: DateTime.parse(json['requestDate'] as String),
      reason: json['reason'] as String,
      activityLog: (json['activityLog'] as List<dynamic>)
          .map((e) => ActivityLogItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LeaveDetailModelToJson(_LeaveDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'approvedBy': instance.approvedBy,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'days': instance.days,
      'approvalDate': instance.approvalDate?.toIso8601String(),
      'requestDate': instance.requestDate.toIso8601String(),
      'reason': instance.reason,
      'activityLog': instance.activityLog,
    };
