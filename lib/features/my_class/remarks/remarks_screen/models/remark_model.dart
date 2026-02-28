import 'package:freezed_annotation/freezed_annotation.dart';

part 'remark_model.freezed.dart';
part 'remark_model.g.dart';

/// Remark category enum
enum RemarkCategory {
  @JsonValue('daily_routine')
  dailyRoutine,
  @JsonValue('behaviour')
  behaviour,
  @JsonValue('class_work')
  classWork,
}

/// Remark type enum
enum RemarkType {
  @JsonValue('positive')
  positive,
  @JsonValue('negative')
  negative,
}

/// Remark severity enum
enum RemarkSeverity {
  @JsonValue('excellent')
  excellent,
  @JsonValue('critical')
  critical,
  @JsonValue('normal')
  normal,
}

/// Remark model - ready for API integration
@freezed
abstract class RemarkModel with _$RemarkModel {
  const factory RemarkModel({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'date') String? date,
    @JsonKey(name: 'category') @Default(RemarkCategory.dailyRoutine) RemarkCategory category,
    @JsonKey(name: 'type') @Default(RemarkType.negative) RemarkType type,
    @JsonKey(name: 'severity') RemarkSeverity? severity,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'createdAt') String? createdAt,
  }) = _RemarkModel;

  factory RemarkModel.fromJson(Map<String, dynamic> json) =>
      _$RemarkModelFromJson(json);
}
