// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VideoItemModel {

@JsonKey(name: 'id') String? get id;@JsonKey(name: 'videoUrl') String? get videoUrl;@JsonKey(name: 'thumbnailUrl') String? get thumbnailUrl;@JsonKey(name: 'duration') String? get duration;@JsonKey(name: 'createdAt') String? get createdAt;
/// Create a copy of VideoItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoItemModelCopyWith<VideoItemModel> get copyWith => _$VideoItemModelCopyWithImpl<VideoItemModel>(this as VideoItemModel, _$identity);

  /// Serializes this VideoItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,videoUrl,thumbnailUrl,duration,createdAt);

@override
String toString() {
  return 'VideoItemModel(id: $id, videoUrl: $videoUrl, thumbnailUrl: $thumbnailUrl, duration: $duration, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $VideoItemModelCopyWith<$Res>  {
  factory $VideoItemModelCopyWith(VideoItemModel value, $Res Function(VideoItemModel) _then) = _$VideoItemModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') String? id,@JsonKey(name: 'videoUrl') String? videoUrl,@JsonKey(name: 'thumbnailUrl') String? thumbnailUrl,@JsonKey(name: 'duration') String? duration,@JsonKey(name: 'createdAt') String? createdAt
});




}
/// @nodoc
class _$VideoItemModelCopyWithImpl<$Res>
    implements $VideoItemModelCopyWith<$Res> {
  _$VideoItemModelCopyWithImpl(this._self, this._then);

  final VideoItemModel _self;
  final $Res Function(VideoItemModel) _then;

/// Create a copy of VideoItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? videoUrl = freezed,Object? thumbnailUrl = freezed,Object? duration = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,videoUrl: freezed == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VideoItemModel].
extension VideoItemModelPatterns on VideoItemModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VideoItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VideoItemModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VideoItemModel value)  $default,){
final _that = this;
switch (_that) {
case _VideoItemModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VideoItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _VideoItemModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String? id, @JsonKey(name: 'videoUrl')  String? videoUrl, @JsonKey(name: 'thumbnailUrl')  String? thumbnailUrl, @JsonKey(name: 'duration')  String? duration, @JsonKey(name: 'createdAt')  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VideoItemModel() when $default != null:
return $default(_that.id,_that.videoUrl,_that.thumbnailUrl,_that.duration,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String? id, @JsonKey(name: 'videoUrl')  String? videoUrl, @JsonKey(name: 'thumbnailUrl')  String? thumbnailUrl, @JsonKey(name: 'duration')  String? duration, @JsonKey(name: 'createdAt')  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _VideoItemModel():
return $default(_that.id,_that.videoUrl,_that.thumbnailUrl,_that.duration,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  String? id, @JsonKey(name: 'videoUrl')  String? videoUrl, @JsonKey(name: 'thumbnailUrl')  String? thumbnailUrl, @JsonKey(name: 'duration')  String? duration, @JsonKey(name: 'createdAt')  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _VideoItemModel() when $default != null:
return $default(_that.id,_that.videoUrl,_that.thumbnailUrl,_that.duration,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VideoItemModel implements VideoItemModel {
  const _VideoItemModel({@JsonKey(name: 'id') this.id, @JsonKey(name: 'videoUrl') this.videoUrl, @JsonKey(name: 'thumbnailUrl') this.thumbnailUrl, @JsonKey(name: 'duration') this.duration, @JsonKey(name: 'createdAt') this.createdAt});
  factory _VideoItemModel.fromJson(Map<String, dynamic> json) => _$VideoItemModelFromJson(json);

@override@JsonKey(name: 'id') final  String? id;
@override@JsonKey(name: 'videoUrl') final  String? videoUrl;
@override@JsonKey(name: 'thumbnailUrl') final  String? thumbnailUrl;
@override@JsonKey(name: 'duration') final  String? duration;
@override@JsonKey(name: 'createdAt') final  String? createdAt;

/// Create a copy of VideoItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VideoItemModelCopyWith<_VideoItemModel> get copyWith => __$VideoItemModelCopyWithImpl<_VideoItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VideoItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VideoItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,videoUrl,thumbnailUrl,duration,createdAt);

@override
String toString() {
  return 'VideoItemModel(id: $id, videoUrl: $videoUrl, thumbnailUrl: $thumbnailUrl, duration: $duration, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$VideoItemModelCopyWith<$Res> implements $VideoItemModelCopyWith<$Res> {
  factory _$VideoItemModelCopyWith(_VideoItemModel value, $Res Function(_VideoItemModel) _then) = __$VideoItemModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') String? id,@JsonKey(name: 'videoUrl') String? videoUrl,@JsonKey(name: 'thumbnailUrl') String? thumbnailUrl,@JsonKey(name: 'duration') String? duration,@JsonKey(name: 'createdAt') String? createdAt
});




}
/// @nodoc
class __$VideoItemModelCopyWithImpl<$Res>
    implements _$VideoItemModelCopyWith<$Res> {
  __$VideoItemModelCopyWithImpl(this._self, this._then);

  final _VideoItemModel _self;
  final $Res Function(_VideoItemModel) _then;

/// Create a copy of VideoItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? videoUrl = freezed,Object? thumbnailUrl = freezed,Object? duration = freezed,Object? createdAt = freezed,}) {
  return _then(_VideoItemModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,videoUrl: freezed == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
