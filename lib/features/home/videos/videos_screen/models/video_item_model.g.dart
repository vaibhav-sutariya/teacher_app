// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VideoItemModel _$VideoItemModelFromJson(Map<String, dynamic> json) =>
    _VideoItemModel(
      id: json['id'] as String?,
      videoUrl: json['videoUrl'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      duration: json['duration'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$VideoItemModelToJson(_VideoItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'videoUrl': instance.videoUrl,
      'thumbnailUrl': instance.thumbnailUrl,
      'duration': instance.duration,
      'createdAt': instance.createdAt,
    };
