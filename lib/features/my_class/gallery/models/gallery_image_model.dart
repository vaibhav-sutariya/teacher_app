import 'package:freezed_annotation/freezed_annotation.dart';

part 'gallery_image_model.freezed.dart';
part 'gallery_image_model.g.dart';

/// Gallery image model - ready for API integration
@freezed
abstract class GalleryImageModel with _$GalleryImageModel {
  const factory GalleryImageModel({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'imageUrl') String? imageUrl,
    @JsonKey(name: 'thumbnailUrl') String? thumbnailUrl,
    @JsonKey(name: 'createdAt') String? createdAt,
  }) = _GalleryImageModel;

  factory GalleryImageModel.fromJson(Map<String, dynamic> json) =>
      _$GalleryImageModelFromJson(json);
}
