// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_detail_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ActivityLogItem {

@JsonKey(name: 'title') String get title;@JsonKey(name: 'subtitle') String get subtitle;@JsonKey(name: 'timestamp') DateTime get timestamp;@JsonKey(name: 'type') ActivityType get type;
/// Create a copy of ActivityLogItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityLogItemCopyWith<ActivityLogItem> get copyWith => _$ActivityLogItemCopyWithImpl<ActivityLogItem>(this as ActivityLogItem, _$identity);

  /// Serializes this ActivityLogItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityLogItem&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,subtitle,timestamp,type);

@override
String toString() {
  return 'ActivityLogItem(title: $title, subtitle: $subtitle, timestamp: $timestamp, type: $type)';
}


}

/// @nodoc
abstract mixin class $ActivityLogItemCopyWith<$Res>  {
  factory $ActivityLogItemCopyWith(ActivityLogItem value, $Res Function(ActivityLogItem) _then) = _$ActivityLogItemCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'title') String title,@JsonKey(name: 'subtitle') String subtitle,@JsonKey(name: 'timestamp') DateTime timestamp,@JsonKey(name: 'type') ActivityType type
});




}
/// @nodoc
class _$ActivityLogItemCopyWithImpl<$Res>
    implements $ActivityLogItemCopyWith<$Res> {
  _$ActivityLogItemCopyWithImpl(this._self, this._then);

  final ActivityLogItem _self;
  final $Res Function(ActivityLogItem) _then;

/// Create a copy of ActivityLogItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? subtitle = null,Object? timestamp = null,Object? type = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ActivityType,
  ));
}

}


/// Adds pattern-matching-related methods to [ActivityLogItem].
extension ActivityLogItemPatterns on ActivityLogItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityLogItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityLogItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityLogItem value)  $default,){
final _that = this;
switch (_that) {
case _ActivityLogItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityLogItem value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityLogItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'title')  String title, @JsonKey(name: 'subtitle')  String subtitle, @JsonKey(name: 'timestamp')  DateTime timestamp, @JsonKey(name: 'type')  ActivityType type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivityLogItem() when $default != null:
return $default(_that.title,_that.subtitle,_that.timestamp,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'title')  String title, @JsonKey(name: 'subtitle')  String subtitle, @JsonKey(name: 'timestamp')  DateTime timestamp, @JsonKey(name: 'type')  ActivityType type)  $default,) {final _that = this;
switch (_that) {
case _ActivityLogItem():
return $default(_that.title,_that.subtitle,_that.timestamp,_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'title')  String title, @JsonKey(name: 'subtitle')  String subtitle, @JsonKey(name: 'timestamp')  DateTime timestamp, @JsonKey(name: 'type')  ActivityType type)?  $default,) {final _that = this;
switch (_that) {
case _ActivityLogItem() when $default != null:
return $default(_that.title,_that.subtitle,_that.timestamp,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActivityLogItem implements ActivityLogItem {
  const _ActivityLogItem({@JsonKey(name: 'title') required this.title, @JsonKey(name: 'subtitle') required this.subtitle, @JsonKey(name: 'timestamp') required this.timestamp, @JsonKey(name: 'type') required this.type});
  factory _ActivityLogItem.fromJson(Map<String, dynamic> json) => _$ActivityLogItemFromJson(json);

@override@JsonKey(name: 'title') final  String title;
@override@JsonKey(name: 'subtitle') final  String subtitle;
@override@JsonKey(name: 'timestamp') final  DateTime timestamp;
@override@JsonKey(name: 'type') final  ActivityType type;

/// Create a copy of ActivityLogItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityLogItemCopyWith<_ActivityLogItem> get copyWith => __$ActivityLogItemCopyWithImpl<_ActivityLogItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivityLogItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityLogItem&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,subtitle,timestamp,type);

@override
String toString() {
  return 'ActivityLogItem(title: $title, subtitle: $subtitle, timestamp: $timestamp, type: $type)';
}


}

/// @nodoc
abstract mixin class _$ActivityLogItemCopyWith<$Res> implements $ActivityLogItemCopyWith<$Res> {
  factory _$ActivityLogItemCopyWith(_ActivityLogItem value, $Res Function(_ActivityLogItem) _then) = __$ActivityLogItemCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'title') String title,@JsonKey(name: 'subtitle') String subtitle,@JsonKey(name: 'timestamp') DateTime timestamp,@JsonKey(name: 'type') ActivityType type
});




}
/// @nodoc
class __$ActivityLogItemCopyWithImpl<$Res>
    implements _$ActivityLogItemCopyWith<$Res> {
  __$ActivityLogItemCopyWithImpl(this._self, this._then);

  final _ActivityLogItem _self;
  final $Res Function(_ActivityLogItem) _then;

/// Create a copy of ActivityLogItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? subtitle = null,Object? timestamp = null,Object? type = null,}) {
  return _then(_ActivityLogItem(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ActivityType,
  ));
}


}


/// @nodoc
mixin _$LeaveDetailModel {

@JsonKey(name: 'id') String get id;@JsonKey(name: 'status') String get status;@JsonKey(name: 'approvedBy') String? get approvedBy;@JsonKey(name: 'startDate') DateTime get startDate;@JsonKey(name: 'endDate') DateTime get endDate;@JsonKey(name: 'days') int get days;@JsonKey(name: 'approvalDate') DateTime? get approvalDate;@JsonKey(name: 'requestDate') DateTime get requestDate;@JsonKey(name: 'reason') String get reason;@JsonKey(name: 'activityLog') List<ActivityLogItem> get activityLog;
/// Create a copy of LeaveDetailModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveDetailModelCopyWith<LeaveDetailModel> get copyWith => _$LeaveDetailModelCopyWithImpl<LeaveDetailModel>(this as LeaveDetailModel, _$identity);

  /// Serializes this LeaveDetailModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveDetailModel&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.approvedBy, approvedBy) || other.approvedBy == approvedBy)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.days, days) || other.days == days)&&(identical(other.approvalDate, approvalDate) || other.approvalDate == approvalDate)&&(identical(other.requestDate, requestDate) || other.requestDate == requestDate)&&(identical(other.reason, reason) || other.reason == reason)&&const DeepCollectionEquality().equals(other.activityLog, activityLog));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,status,approvedBy,startDate,endDate,days,approvalDate,requestDate,reason,const DeepCollectionEquality().hash(activityLog));

@override
String toString() {
  return 'LeaveDetailModel(id: $id, status: $status, approvedBy: $approvedBy, startDate: $startDate, endDate: $endDate, days: $days, approvalDate: $approvalDate, requestDate: $requestDate, reason: $reason, activityLog: $activityLog)';
}


}

/// @nodoc
abstract mixin class $LeaveDetailModelCopyWith<$Res>  {
  factory $LeaveDetailModelCopyWith(LeaveDetailModel value, $Res Function(LeaveDetailModel) _then) = _$LeaveDetailModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'status') String status,@JsonKey(name: 'approvedBy') String? approvedBy,@JsonKey(name: 'startDate') DateTime startDate,@JsonKey(name: 'endDate') DateTime endDate,@JsonKey(name: 'days') int days,@JsonKey(name: 'approvalDate') DateTime? approvalDate,@JsonKey(name: 'requestDate') DateTime requestDate,@JsonKey(name: 'reason') String reason,@JsonKey(name: 'activityLog') List<ActivityLogItem> activityLog
});




}
/// @nodoc
class _$LeaveDetailModelCopyWithImpl<$Res>
    implements $LeaveDetailModelCopyWith<$Res> {
  _$LeaveDetailModelCopyWithImpl(this._self, this._then);

  final LeaveDetailModel _self;
  final $Res Function(LeaveDetailModel) _then;

/// Create a copy of LeaveDetailModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? status = null,Object? approvedBy = freezed,Object? startDate = null,Object? endDate = null,Object? days = null,Object? approvalDate = freezed,Object? requestDate = null,Object? reason = null,Object? activityLog = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,approvedBy: freezed == approvedBy ? _self.approvedBy : approvedBy // ignore: cast_nullable_to_non_nullable
as String?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int,approvalDate: freezed == approvalDate ? _self.approvalDate : approvalDate // ignore: cast_nullable_to_non_nullable
as DateTime?,requestDate: null == requestDate ? _self.requestDate : requestDate // ignore: cast_nullable_to_non_nullable
as DateTime,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,activityLog: null == activityLog ? _self.activityLog : activityLog // ignore: cast_nullable_to_non_nullable
as List<ActivityLogItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [LeaveDetailModel].
extension LeaveDetailModelPatterns on LeaveDetailModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaveDetailModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaveDetailModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaveDetailModel value)  $default,){
final _that = this;
switch (_that) {
case _LeaveDetailModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaveDetailModel value)?  $default,){
final _that = this;
switch (_that) {
case _LeaveDetailModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'status')  String status, @JsonKey(name: 'approvedBy')  String? approvedBy, @JsonKey(name: 'startDate')  DateTime startDate, @JsonKey(name: 'endDate')  DateTime endDate, @JsonKey(name: 'days')  int days, @JsonKey(name: 'approvalDate')  DateTime? approvalDate, @JsonKey(name: 'requestDate')  DateTime requestDate, @JsonKey(name: 'reason')  String reason, @JsonKey(name: 'activityLog')  List<ActivityLogItem> activityLog)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveDetailModel() when $default != null:
return $default(_that.id,_that.status,_that.approvedBy,_that.startDate,_that.endDate,_that.days,_that.approvalDate,_that.requestDate,_that.reason,_that.activityLog);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'status')  String status, @JsonKey(name: 'approvedBy')  String? approvedBy, @JsonKey(name: 'startDate')  DateTime startDate, @JsonKey(name: 'endDate')  DateTime endDate, @JsonKey(name: 'days')  int days, @JsonKey(name: 'approvalDate')  DateTime? approvalDate, @JsonKey(name: 'requestDate')  DateTime requestDate, @JsonKey(name: 'reason')  String reason, @JsonKey(name: 'activityLog')  List<ActivityLogItem> activityLog)  $default,) {final _that = this;
switch (_that) {
case _LeaveDetailModel():
return $default(_that.id,_that.status,_that.approvedBy,_that.startDate,_that.endDate,_that.days,_that.approvalDate,_that.requestDate,_that.reason,_that.activityLog);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'status')  String status, @JsonKey(name: 'approvedBy')  String? approvedBy, @JsonKey(name: 'startDate')  DateTime startDate, @JsonKey(name: 'endDate')  DateTime endDate, @JsonKey(name: 'days')  int days, @JsonKey(name: 'approvalDate')  DateTime? approvalDate, @JsonKey(name: 'requestDate')  DateTime requestDate, @JsonKey(name: 'reason')  String reason, @JsonKey(name: 'activityLog')  List<ActivityLogItem> activityLog)?  $default,) {final _that = this;
switch (_that) {
case _LeaveDetailModel() when $default != null:
return $default(_that.id,_that.status,_that.approvedBy,_that.startDate,_that.endDate,_that.days,_that.approvalDate,_that.requestDate,_that.reason,_that.activityLog);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeaveDetailModel implements LeaveDetailModel {
  const _LeaveDetailModel({@JsonKey(name: 'id') required this.id, @JsonKey(name: 'status') required this.status, @JsonKey(name: 'approvedBy') this.approvedBy, @JsonKey(name: 'startDate') required this.startDate, @JsonKey(name: 'endDate') required this.endDate, @JsonKey(name: 'days') required this.days, @JsonKey(name: 'approvalDate') this.approvalDate, @JsonKey(name: 'requestDate') required this.requestDate, @JsonKey(name: 'reason') required this.reason, @JsonKey(name: 'activityLog') required final  List<ActivityLogItem> activityLog}): _activityLog = activityLog;
  factory _LeaveDetailModel.fromJson(Map<String, dynamic> json) => _$LeaveDetailModelFromJson(json);

@override@JsonKey(name: 'id') final  String id;
@override@JsonKey(name: 'status') final  String status;
@override@JsonKey(name: 'approvedBy') final  String? approvedBy;
@override@JsonKey(name: 'startDate') final  DateTime startDate;
@override@JsonKey(name: 'endDate') final  DateTime endDate;
@override@JsonKey(name: 'days') final  int days;
@override@JsonKey(name: 'approvalDate') final  DateTime? approvalDate;
@override@JsonKey(name: 'requestDate') final  DateTime requestDate;
@override@JsonKey(name: 'reason') final  String reason;
 final  List<ActivityLogItem> _activityLog;
@override@JsonKey(name: 'activityLog') List<ActivityLogItem> get activityLog {
  if (_activityLog is EqualUnmodifiableListView) return _activityLog;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_activityLog);
}


/// Create a copy of LeaveDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveDetailModelCopyWith<_LeaveDetailModel> get copyWith => __$LeaveDetailModelCopyWithImpl<_LeaveDetailModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeaveDetailModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveDetailModel&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.approvedBy, approvedBy) || other.approvedBy == approvedBy)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.days, days) || other.days == days)&&(identical(other.approvalDate, approvalDate) || other.approvalDate == approvalDate)&&(identical(other.requestDate, requestDate) || other.requestDate == requestDate)&&(identical(other.reason, reason) || other.reason == reason)&&const DeepCollectionEquality().equals(other._activityLog, _activityLog));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,status,approvedBy,startDate,endDate,days,approvalDate,requestDate,reason,const DeepCollectionEquality().hash(_activityLog));

@override
String toString() {
  return 'LeaveDetailModel(id: $id, status: $status, approvedBy: $approvedBy, startDate: $startDate, endDate: $endDate, days: $days, approvalDate: $approvalDate, requestDate: $requestDate, reason: $reason, activityLog: $activityLog)';
}


}

/// @nodoc
abstract mixin class _$LeaveDetailModelCopyWith<$Res> implements $LeaveDetailModelCopyWith<$Res> {
  factory _$LeaveDetailModelCopyWith(_LeaveDetailModel value, $Res Function(_LeaveDetailModel) _then) = __$LeaveDetailModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'status') String status,@JsonKey(name: 'approvedBy') String? approvedBy,@JsonKey(name: 'startDate') DateTime startDate,@JsonKey(name: 'endDate') DateTime endDate,@JsonKey(name: 'days') int days,@JsonKey(name: 'approvalDate') DateTime? approvalDate,@JsonKey(name: 'requestDate') DateTime requestDate,@JsonKey(name: 'reason') String reason,@JsonKey(name: 'activityLog') List<ActivityLogItem> activityLog
});




}
/// @nodoc
class __$LeaveDetailModelCopyWithImpl<$Res>
    implements _$LeaveDetailModelCopyWith<$Res> {
  __$LeaveDetailModelCopyWithImpl(this._self, this._then);

  final _LeaveDetailModel _self;
  final $Res Function(_LeaveDetailModel) _then;

/// Create a copy of LeaveDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? status = null,Object? approvedBy = freezed,Object? startDate = null,Object? endDate = null,Object? days = null,Object? approvalDate = freezed,Object? requestDate = null,Object? reason = null,Object? activityLog = null,}) {
  return _then(_LeaveDetailModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,approvedBy: freezed == approvedBy ? _self.approvedBy : approvedBy // ignore: cast_nullable_to_non_nullable
as String?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int,approvalDate: freezed == approvalDate ? _self.approvalDate : approvalDate // ignore: cast_nullable_to_non_nullable
as DateTime?,requestDate: null == requestDate ? _self.requestDate : requestDate // ignore: cast_nullable_to_non_nullable
as DateTime,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,activityLog: null == activityLog ? _self._activityLog : activityLog // ignore: cast_nullable_to_non_nullable
as List<ActivityLogItem>,
  ));
}


}

// dart format on
