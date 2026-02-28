import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_item_model.freezed.dart';
part 'video_item_model.g.dart';

/// Video item model - ready for API integration
@freezed
abstract class VideoItemModel with _$VideoItemModel {
  const factory VideoItemModel({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'videoUrl') String? videoUrl,
    @JsonKey(name: 'thumbnailUrl') String? thumbnailUrl,
    @JsonKey(name: 'duration') String? duration,
    @JsonKey(name: 'createdAt') String? createdAt,
  }) = _VideoItemModel;

  factory VideoItemModel.fromJson(Map<String, dynamic> json) =>
      _$VideoItemModelFromJson(json);
}
