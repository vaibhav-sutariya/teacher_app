import 'package:freezed_annotation/freezed_annotation.dart';

part 'gallery_model.freezed.dart';
part 'gallery_model.g.dart';

/// Gallery album model - ready for API integration
@freezed
abstract class GalleryModel with _$GalleryModel {
  const factory GalleryModel({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'imageUrl') String? imageUrl,
    @JsonKey(name: 'photoCount') int? photoCount,
    @JsonKey(name: 'createdAt') String? createdAt,
  }) = _GalleryModel;

  factory GalleryModel.fromJson(Map<String, dynamic> json) =>
      _$GalleryModelFromJson(json);
}
