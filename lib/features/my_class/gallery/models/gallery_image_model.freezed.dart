// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gallery_image_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GalleryImageModel {

@JsonKey(name: 'id') String? get id;@JsonKey(name: 'imageUrl') String? get imageUrl;@JsonKey(name: 'thumbnailUrl') String? get thumbnailUrl;@JsonKey(name: 'createdAt') String? get createdAt;
/// Create a copy of GalleryImageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GalleryImageModelCopyWith<GalleryImageModel> get copyWith => _$GalleryImageModelCopyWithImpl<GalleryImageModel>(this as GalleryImageModel, _$identity);

  /// Serializes this GalleryImageModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GalleryImageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,imageUrl,thumbnailUrl,createdAt);

@override
String toString() {
  return 'GalleryImageModel(id: $id, imageUrl: $imageUrl, thumbnailUrl: $thumbnailUrl, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $GalleryImageModelCopyWith<$Res>  {
  factory $GalleryImageModelCopyWith(GalleryImageModel value, $Res Function(GalleryImageModel) _then) = _$GalleryImageModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') String? id,@JsonKey(name: 'imageUrl') String? imageUrl,@JsonKey(name: 'thumbnailUrl') String? thumbnailUrl,@JsonKey(name: 'createdAt') String? createdAt
});




}
/// @nodoc
class _$GalleryImageModelCopyWithImpl<$Res>
    implements $GalleryImageModelCopyWith<$Res> {
  _$GalleryImageModelCopyWithImpl(this._self, this._then);

  final GalleryImageModel _self;
  final $Res Function(GalleryImageModel) _then;

/// Create a copy of GalleryImageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? imageUrl = freezed,Object? thumbnailUrl = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GalleryImageModel].
extension GalleryImageModelPatterns on GalleryImageModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GalleryImageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GalleryImageModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GalleryImageModel value)  $default,){
final _that = this;
switch (_that) {
case _GalleryImageModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GalleryImageModel value)?  $default,){
final _that = this;
switch (_that) {
case _GalleryImageModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String? id, @JsonKey(name: 'imageUrl')  String? imageUrl, @JsonKey(name: 'thumbnailUrl')  String? thumbnailUrl, @JsonKey(name: 'createdAt')  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GalleryImageModel() when $default != null:
return $default(_that.id,_that.imageUrl,_that.thumbnailUrl,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String? id, @JsonKey(name: 'imageUrl')  String? imageUrl, @JsonKey(name: 'thumbnailUrl')  String? thumbnailUrl, @JsonKey(name: 'createdAt')  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _GalleryImageModel():
return $default(_that.id,_that.imageUrl,_that.thumbnailUrl,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  String? id, @JsonKey(name: 'imageUrl')  String? imageUrl, @JsonKey(name: 'thumbnailUrl')  String? thumbnailUrl, @JsonKey(name: 'createdAt')  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _GalleryImageModel() when $default != null:
return $default(_that.id,_that.imageUrl,_that.thumbnailUrl,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GalleryImageModel implements GalleryImageModel {
  const _GalleryImageModel({@JsonKey(name: 'id') this.id, @JsonKey(name: 'imageUrl') this.imageUrl, @JsonKey(name: 'thumbnailUrl') this.thumbnailUrl, @JsonKey(name: 'createdAt') this.createdAt});
  factory _GalleryImageModel.fromJson(Map<String, dynamic> json) => _$GalleryImageModelFromJson(json);

@override@JsonKey(name: 'id') final  String? id;
@override@JsonKey(name: 'imageUrl') final  String? imageUrl;
@override@JsonKey(name: 'thumbnailUrl') final  String? thumbnailUrl;
@override@JsonKey(name: 'createdAt') final  String? createdAt;

/// Create a copy of GalleryImageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GalleryImageModelCopyWith<_GalleryImageModel> get copyWith => __$GalleryImageModelCopyWithImpl<_GalleryImageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GalleryImageModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GalleryImageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,imageUrl,thumbnailUrl,createdAt);

@override
String toString() {
  return 'GalleryImageModel(id: $id, imageUrl: $imageUrl, thumbnailUrl: $thumbnailUrl, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$GalleryImageModelCopyWith<$Res> implements $GalleryImageModelCopyWith<$Res> {
  factory _$GalleryImageModelCopyWith(_GalleryImageModel value, $Res Function(_GalleryImageModel) _then) = __$GalleryImageModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') String? id,@JsonKey(name: 'imageUrl') String? imageUrl,@JsonKey(name: 'thumbnailUrl') String? thumbnailUrl,@JsonKey(name: 'createdAt') String? createdAt
});




}
/// @nodoc
class __$GalleryImageModelCopyWithImpl<$Res>
    implements _$GalleryImageModelCopyWith<$Res> {
  __$GalleryImageModelCopyWithImpl(this._self, this._then);

  final _GalleryImageModel _self;
  final $Res Function(_GalleryImageModel) _then;

/// Create a copy of GalleryImageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? imageUrl = freezed,Object? thumbnailUrl = freezed,Object? createdAt = freezed,}) {
  return _then(_GalleryImageModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
