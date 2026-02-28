// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gallery_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GalleryModel _$GalleryModelFromJson(Map<String, dynamic> json) =>
    _GalleryModel(
      id: json['id'] as String?,
      title: json['title'] as String?,
      imageUrl: json['imageUrl'] as String?,
      photoCount: (json['photoCount'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$GalleryModelToJson(_GalleryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'photoCount': instance.photoCount,
      'createdAt': instance.createdAt,
    };
