// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AttendanceModel {

@JsonKey(name: 'studentId') String? get studentId;@JsonKey(name: 'studentName') String? get studentName;@JsonKey(name: 'academicYear') String? get academicYear;@JsonKey(name: 'className') String? get className;@JsonKey(name: 'totalDays') int? get totalDays;@JsonKey(name: 'presentDays') int? get presentDays;@JsonKey(name: 'absentDays') int? get absentDays;@JsonKey(name: 'overallPercentage') double? get overallPercentage;@JsonKey(name: 'attendanceData') Map<String, String>? get attendanceData;@JsonKey(name: 'feedbackMessage') String? get feedbackMessage;@JsonKey(name: 'classAverage') double? get classAverage;
/// Create a copy of AttendanceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceModelCopyWith<AttendanceModel> get copyWith => _$AttendanceModelCopyWithImpl<AttendanceModel>(this as AttendanceModel, _$identity);

  /// Serializes this AttendanceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceModel&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.studentName, studentName) || other.studentName == studentName)&&(identical(other.academicYear, academicYear) || other.academicYear == academicYear)&&(identical(other.className, className) || other.className == className)&&(identical(other.totalDays, totalDays) || other.totalDays == totalDays)&&(identical(other.presentDays, presentDays) || other.presentDays == presentDays)&&(identical(other.absentDays, absentDays) || other.absentDays == absentDays)&&(identical(other.overallPercentage, overallPercentage) || other.overallPercentage == overallPercentage)&&const DeepCollectionEquality().equals(other.attendanceData, attendanceData)&&(identical(other.feedbackMessage, feedbackMessage) || other.feedbackMessage == feedbackMessage)&&(identical(other.classAverage, classAverage) || other.classAverage == classAverage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,studentId,studentName,academicYear,className,totalDays,presentDays,absentDays,overallPercentage,const DeepCollectionEquality().hash(attendanceData),feedbackMessage,classAverage);

@override
String toString() {
  return 'AttendanceModel(studentId: $studentId, studentName: $studentName, academicYear: $academicYear, className: $className, totalDays: $totalDays, presentDays: $presentDays, absentDays: $absentDays, overallPercentage: $overallPercentage, attendanceData: $attendanceData, feedbackMessage: $feedbackMessage, classAverage: $classAverage)';
}


}

/// @nodoc
abstract mixin class $AttendanceModelCopyWith<$Res>  {
  factory $AttendanceModelCopyWith(AttendanceModel value, $Res Function(AttendanceModel) _then) = _$AttendanceModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'studentId') String? studentId,@JsonKey(name: 'studentName') String? studentName,@JsonKey(name: 'academicYear') String? academicYear,@JsonKey(name: 'className') String? className,@JsonKey(name: 'totalDays') int? totalDays,@JsonKey(name: 'presentDays') int? presentDays,@JsonKey(name: 'absentDays') int? absentDays,@JsonKey(name: 'overallPercentage') double? overallPercentage,@JsonKey(name: 'attendanceData') Map<String, String>? attendanceData,@JsonKey(name: 'feedbackMessage') String? feedbackMessage,@JsonKey(name: 'classAverage') double? classAverage
});




}
/// @nodoc
class _$AttendanceModelCopyWithImpl<$Res>
    implements $AttendanceModelCopyWith<$Res> {
  _$AttendanceModelCopyWithImpl(this._self, this._then);

  final AttendanceModel _self;
  final $Res Function(AttendanceModel) _then;

/// Create a copy of AttendanceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? studentId = freezed,Object? studentName = freezed,Object? academicYear = freezed,Object? className = freezed,Object? totalDays = freezed,Object? presentDays = freezed,Object? absentDays = freezed,Object? overallPercentage = freezed,Object? attendanceData = freezed,Object? feedbackMessage = freezed,Object? classAverage = freezed,}) {
  return _then(_self.copyWith(
studentId: freezed == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String?,studentName: freezed == studentName ? _self.studentName : studentName // ignore: cast_nullable_to_non_nullable
as String?,academicYear: freezed == academicYear ? _self.academicYear : academicYear // ignore: cast_nullable_to_non_nullable
as String?,className: freezed == className ? _self.className : className // ignore: cast_nullable_to_non_nullable
as String?,totalDays: freezed == totalDays ? _self.totalDays : totalDays // ignore: cast_nullable_to_non_nullable
as int?,presentDays: freezed == presentDays ? _self.presentDays : presentDays // ignore: cast_nullable_to_non_nullable
as int?,absentDays: freezed == absentDays ? _self.absentDays : absentDays // ignore: cast_nullable_to_non_nullable
as int?,overallPercentage: freezed == overallPercentage ? _self.overallPercentage : overallPercentage // ignore: cast_nullable_to_non_nullable
as double?,attendanceData: freezed == attendanceData ? _self.attendanceData : attendanceData // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,feedbackMessage: freezed == feedbackMessage ? _self.feedbackMessage : feedbackMessage // ignore: cast_nullable_to_non_nullable
as String?,classAverage: freezed == classAverage ? _self.classAverage : classAverage // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [AttendanceModel].
extension AttendanceModelPatterns on AttendanceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttendanceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttendanceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttendanceModel value)  $default,){
final _that = this;
switch (_that) {
case _AttendanceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttendanceModel value)?  $default,){
final _that = this;
switch (_that) {
case _AttendanceModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'studentId')  String? studentId, @JsonKey(name: 'studentName')  String? studentName, @JsonKey(name: 'academicYear')  String? academicYear, @JsonKey(name: 'className')  String? className, @JsonKey(name: 'totalDays')  int? totalDays, @JsonKey(name: 'presentDays')  int? presentDays, @JsonKey(name: 'absentDays')  int? absentDays, @JsonKey(name: 'overallPercentage')  double? overallPercentage, @JsonKey(name: 'attendanceData')  Map<String, String>? attendanceData, @JsonKey(name: 'feedbackMessage')  String? feedbackMessage, @JsonKey(name: 'classAverage')  double? classAverage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttendanceModel() when $default != null:
return $default(_that.studentId,_that.studentName,_that.academicYear,_that.className,_that.totalDays,_that.presentDays,_that.absentDays,_that.overallPercentage,_that.attendanceData,_that.feedbackMessage,_that.classAverage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'studentId')  String? studentId, @JsonKey(name: 'studentName')  String? studentName, @JsonKey(name: 'academicYear')  String? academicYear, @JsonKey(name: 'className')  String? className, @JsonKey(name: 'totalDays')  int? totalDays, @JsonKey(name: 'presentDays')  int? presentDays, @JsonKey(name: 'absentDays')  int? absentDays, @JsonKey(name: 'overallPercentage')  double? overallPercentage, @JsonKey(name: 'attendanceData')  Map<String, String>? attendanceData, @JsonKey(name: 'feedbackMessage')  String? feedbackMessage, @JsonKey(name: 'classAverage')  double? classAverage)  $default,) {final _that = this;
switch (_that) {
case _AttendanceModel():
return $default(_that.studentId,_that.studentName,_that.academicYear,_that.className,_that.totalDays,_that.presentDays,_that.absentDays,_that.overallPercentage,_that.attendanceData,_that.feedbackMessage,_that.classAverage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'studentId')  String? studentId, @JsonKey(name: 'studentName')  String? studentName, @JsonKey(name: 'academicYear')  String? academicYear, @JsonKey(name: 'className')  String? className, @JsonKey(name: 'totalDays')  int? totalDays, @JsonKey(name: 'presentDays')  int? presentDays, @JsonKey(name: 'absentDays')  int? absentDays, @JsonKey(name: 'overallPercentage')  double? overallPercentage, @JsonKey(name: 'attendanceData')  Map<String, String>? attendanceData, @JsonKey(name: 'feedbackMessage')  String? feedbackMessage, @JsonKey(name: 'classAverage')  double? classAverage)?  $default,) {final _that = this;
switch (_that) {
case _AttendanceModel() when $default != null:
return $default(_that.studentId,_that.studentName,_that.academicYear,_that.className,_that.totalDays,_that.presentDays,_that.absentDays,_that.overallPercentage,_that.attendanceData,_that.feedbackMessage,_that.classAverage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AttendanceModel implements AttendanceModel {
  const _AttendanceModel({@JsonKey(name: 'studentId') this.studentId, @JsonKey(name: 'studentName') this.studentName, @JsonKey(name: 'academicYear') this.academicYear, @JsonKey(name: 'className') this.className, @JsonKey(name: 'totalDays') this.totalDays, @JsonKey(name: 'presentDays') this.presentDays, @JsonKey(name: 'absentDays') this.absentDays, @JsonKey(name: 'overallPercentage') this.overallPercentage, @JsonKey(name: 'attendanceData') final  Map<String, String>? attendanceData, @JsonKey(name: 'feedbackMessage') this.feedbackMessage, @JsonKey(name: 'classAverage') this.classAverage}): _attendanceData = attendanceData;
  factory _AttendanceModel.fromJson(Map<String, dynamic> json) => _$AttendanceModelFromJson(json);

@override@JsonKey(name: 'studentId') final  String? studentId;
@override@JsonKey(name: 'studentName') final  String? studentName;
@override@JsonKey(name: 'academicYear') final  String? academicYear;
@override@JsonKey(name: 'className') final  String? className;
@override@JsonKey(name: 'totalDays') final  int? totalDays;
@override@JsonKey(name: 'presentDays') final  int? presentDays;
@override@JsonKey(name: 'absentDays') final  int? absentDays;
@override@JsonKey(name: 'overallPercentage') final  double? overallPercentage;
 final  Map<String, String>? _attendanceData;
@override@JsonKey(name: 'attendanceData') Map<String, String>? get attendanceData {
  final value = _attendanceData;
  if (value == null) return null;
  if (_attendanceData is EqualUnmodifiableMapView) return _attendanceData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@JsonKey(name: 'feedbackMessage') final  String? feedbackMessage;
@override@JsonKey(name: 'classAverage') final  double? classAverage;

/// Create a copy of AttendanceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttendanceModelCopyWith<_AttendanceModel> get copyWith => __$AttendanceModelCopyWithImpl<_AttendanceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttendanceModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttendanceModel&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.studentName, studentName) || other.studentName == studentName)&&(identical(other.academicYear, academicYear) || other.academicYear == academicYear)&&(identical(other.className, className) || other.className == className)&&(identical(other.totalDays, totalDays) || other.totalDays == totalDays)&&(identical(other.presentDays, presentDays) || other.presentDays == presentDays)&&(identical(other.absentDays, absentDays) || other.absentDays == absentDays)&&(identical(other.overallPercentage, overallPercentage) || other.overallPercentage == overallPercentage)&&const DeepCollectionEquality().equals(other._attendanceData, _attendanceData)&&(identical(other.feedbackMessage, feedbackMessage) || other.feedbackMessage == feedbackMessage)&&(identical(other.classAverage, classAverage) || other.classAverage == classAverage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,studentId,studentName,academicYear,className,totalDays,presentDays,absentDays,overallPercentage,const DeepCollectionEquality().hash(_attendanceData),feedbackMessage,classAverage);

@override
String toString() {
  return 'AttendanceModel(studentId: $studentId, studentName: $studentName, academicYear: $academicYear, className: $className, totalDays: $totalDays, presentDays: $presentDays, absentDays: $absentDays, overallPercentage: $overallPercentage, attendanceData: $attendanceData, feedbackMessage: $feedbackMessage, classAverage: $classAverage)';
}


}

/// @nodoc
abstract mixin class _$AttendanceModelCopyWith<$Res> implements $AttendanceModelCopyWith<$Res> {
  factory _$AttendanceModelCopyWith(_AttendanceModel value, $Res Function(_AttendanceModel) _then) = __$AttendanceModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'studentId') String? studentId,@JsonKey(name: 'studentName') String? studentName,@JsonKey(name: 'academicYear') String? academicYear,@JsonKey(name: 'className') String? className,@JsonKey(name: 'totalDays') int? totalDays,@JsonKey(name: 'presentDays') int? presentDays,@JsonKey(name: 'absentDays') int? absentDays,@JsonKey(name: 'overallPercentage') double? overallPercentage,@JsonKey(name: 'attendanceData') Map<String, String>? attendanceData,@JsonKey(name: 'feedbackMessage') String? feedbackMessage,@JsonKey(name: 'classAverage') double? classAverage
});




}
/// @nodoc
class __$AttendanceModelCopyWithImpl<$Res>
    implements _$AttendanceModelCopyWith<$Res> {
  __$AttendanceModelCopyWithImpl(this._self, this._then);

  final _AttendanceModel _self;
  final $Res Function(_AttendanceModel) _then;

/// Create a copy of AttendanceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? studentId = freezed,Object? studentName = freezed,Object? academicYear = freezed,Object? className = freezed,Object? totalDays = freezed,Object? presentDays = freezed,Object? absentDays = freezed,Object? overallPercentage = freezed,Object? attendanceData = freezed,Object? feedbackMessage = freezed,Object? classAverage = freezed,}) {
  return _then(_AttendanceModel(
studentId: freezed == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String?,studentName: freezed == studentName ? _self.studentName : studentName // ignore: cast_nullable_to_non_nullable
as String?,academicYear: freezed == academicYear ? _self.academicYear : academicYear // ignore: cast_nullable_to_non_nullable
as String?,className: freezed == className ? _self.className : className // ignore: cast_nullable_to_non_nullable
as String?,totalDays: freezed == totalDays ? _self.totalDays : totalDays // ignore: cast_nullable_to_non_nullable
as int?,presentDays: freezed == presentDays ? _self.presentDays : presentDays // ignore: cast_nullable_to_non_nullable
as int?,absentDays: freezed == absentDays ? _self.absentDays : absentDays // ignore: cast_nullable_to_non_nullable
as int?,overallPercentage: freezed == overallPercentage ? _self.overallPercentage : overallPercentage // ignore: cast_nullable_to_non_nullable
as double?,attendanceData: freezed == attendanceData ? _self._attendanceData : attendanceData // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,feedbackMessage: freezed == feedbackMessage ? _self.feedbackMessage : feedbackMessage // ignore: cast_nullable_to_non_nullable
as String?,classAverage: freezed == classAverage ? _self.classAverage : classAverage // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
