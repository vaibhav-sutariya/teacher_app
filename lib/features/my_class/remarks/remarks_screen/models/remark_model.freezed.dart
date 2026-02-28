// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'remark_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RemarkModel {

@JsonKey(name: 'id') String? get id;@JsonKey(name: 'date') String? get date;@JsonKey(name: 'category') RemarkCategory get category;@JsonKey(name: 'type') RemarkType get type;@JsonKey(name: 'severity') RemarkSeverity? get severity;@JsonKey(name: 'description') String? get description;@JsonKey(name: 'createdAt') String? get createdAt;
/// Create a copy of RemarkModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RemarkModelCopyWith<RemarkModel> get copyWith => _$RemarkModelCopyWithImpl<RemarkModel>(this as RemarkModel, _$identity);

  /// Serializes this RemarkModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RemarkModel&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.category, category) || other.category == category)&&(identical(other.type, type) || other.type == type)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,date,category,type,severity,description,createdAt);

@override
String toString() {
  return 'RemarkModel(id: $id, date: $date, category: $category, type: $type, severity: $severity, description: $description, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $RemarkModelCopyWith<$Res>  {
  factory $RemarkModelCopyWith(RemarkModel value, $Res Function(RemarkModel) _then) = _$RemarkModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') String? id,@JsonKey(name: 'date') String? date,@JsonKey(name: 'category') RemarkCategory category,@JsonKey(name: 'type') RemarkType type,@JsonKey(name: 'severity') RemarkSeverity? severity,@JsonKey(name: 'description') String? description,@JsonKey(name: 'createdAt') String? createdAt
});




}
/// @nodoc
class _$RemarkModelCopyWithImpl<$Res>
    implements $RemarkModelCopyWith<$Res> {
  _$RemarkModelCopyWithImpl(this._self, this._then);

  final RemarkModel _self;
  final $Res Function(RemarkModel) _then;

/// Create a copy of RemarkModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? date = freezed,Object? category = null,Object? type = null,Object? severity = freezed,Object? description = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as RemarkCategory,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RemarkType,severity: freezed == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as RemarkSeverity?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RemarkModel].
extension RemarkModelPatterns on RemarkModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RemarkModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RemarkModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RemarkModel value)  $default,){
final _that = this;
switch (_that) {
case _RemarkModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RemarkModel value)?  $default,){
final _that = this;
switch (_that) {
case _RemarkModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String? id, @JsonKey(name: 'date')  String? date, @JsonKey(name: 'category')  RemarkCategory category, @JsonKey(name: 'type')  RemarkType type, @JsonKey(name: 'severity')  RemarkSeverity? severity, @JsonKey(name: 'description')  String? description, @JsonKey(name: 'createdAt')  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RemarkModel() when $default != null:
return $default(_that.id,_that.date,_that.category,_that.type,_that.severity,_that.description,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String? id, @JsonKey(name: 'date')  String? date, @JsonKey(name: 'category')  RemarkCategory category, @JsonKey(name: 'type')  RemarkType type, @JsonKey(name: 'severity')  RemarkSeverity? severity, @JsonKey(name: 'description')  String? description, @JsonKey(name: 'createdAt')  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _RemarkModel():
return $default(_that.id,_that.date,_that.category,_that.type,_that.severity,_that.description,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  String? id, @JsonKey(name: 'date')  String? date, @JsonKey(name: 'category')  RemarkCategory category, @JsonKey(name: 'type')  RemarkType type, @JsonKey(name: 'severity')  RemarkSeverity? severity, @JsonKey(name: 'description')  String? description, @JsonKey(name: 'createdAt')  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _RemarkModel() when $default != null:
return $default(_that.id,_that.date,_that.category,_that.type,_that.severity,_that.description,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RemarkModel implements RemarkModel {
  const _RemarkModel({@JsonKey(name: 'id') this.id, @JsonKey(name: 'date') this.date, @JsonKey(name: 'category') this.category = RemarkCategory.dailyRoutine, @JsonKey(name: 'type') this.type = RemarkType.negative, @JsonKey(name: 'severity') this.severity, @JsonKey(name: 'description') this.description, @JsonKey(name: 'createdAt') this.createdAt});
  factory _RemarkModel.fromJson(Map<String, dynamic> json) => _$RemarkModelFromJson(json);

@override@JsonKey(name: 'id') final  String? id;
@override@JsonKey(name: 'date') final  String? date;
@override@JsonKey(name: 'category') final  RemarkCategory category;
@override@JsonKey(name: 'type') final  RemarkType type;
@override@JsonKey(name: 'severity') final  RemarkSeverity? severity;
@override@JsonKey(name: 'description') final  String? description;
@override@JsonKey(name: 'createdAt') final  String? createdAt;

/// Create a copy of RemarkModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemarkModelCopyWith<_RemarkModel> get copyWith => __$RemarkModelCopyWithImpl<_RemarkModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RemarkModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RemarkModel&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.category, category) || other.category == category)&&(identical(other.type, type) || other.type == type)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,date,category,type,severity,description,createdAt);

@override
String toString() {
  return 'RemarkModel(id: $id, date: $date, category: $category, type: $type, severity: $severity, description: $description, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$RemarkModelCopyWith<$Res> implements $RemarkModelCopyWith<$Res> {
  factory _$RemarkModelCopyWith(_RemarkModel value, $Res Function(_RemarkModel) _then) = __$RemarkModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') String? id,@JsonKey(name: 'date') String? date,@JsonKey(name: 'category') RemarkCategory category,@JsonKey(name: 'type') RemarkType type,@JsonKey(name: 'severity') RemarkSeverity? severity,@JsonKey(name: 'description') String? description,@JsonKey(name: 'createdAt') String? createdAt
});




}
/// @nodoc
class __$RemarkModelCopyWithImpl<$Res>
    implements _$RemarkModelCopyWith<$Res> {
  __$RemarkModelCopyWithImpl(this._self, this._then);

  final _RemarkModel _self;
  final $Res Function(_RemarkModel) _then;

/// Create a copy of RemarkModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? date = freezed,Object? category = null,Object? type = null,Object? severity = freezed,Object? description = freezed,Object? createdAt = freezed,}) {
  return _then(_RemarkModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as RemarkCategory,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RemarkType,severity: freezed == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as RemarkSeverity?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
