// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gallery_image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GalleryImageModel _$GalleryImageModelFromJson(Map<String, dynamic> json) =>
    _GalleryImageModel(
      id: json['id'] as String?,
      imageUrl: json['imageUrl'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$GalleryImageModelToJson(_GalleryImageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'thumbnailUrl': instance.thumbnailUrl,
      'createdAt': instance.createdAt,
    };
