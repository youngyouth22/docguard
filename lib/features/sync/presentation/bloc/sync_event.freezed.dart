// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SyncEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SyncEvent()';
}


}

/// @nodoc
class $SyncEventCopyWith<$Res>  {
$SyncEventCopyWith(SyncEvent _, $Res Function(SyncEvent) __);
}


/// Adds pattern-matching-related methods to [SyncEvent].
extension SyncEventPatterns on SyncEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SyncStarted value)?  syncStarted,TResult Function( SyncStatusUpdated value)?  statusUpdated,TResult Function( AttachmentStatusUpdated value)?  attachmentStatusUpdated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SyncStarted() when syncStarted != null:
return syncStarted(_that);case SyncStatusUpdated() when statusUpdated != null:
return statusUpdated(_that);case AttachmentStatusUpdated() when attachmentStatusUpdated != null:
return attachmentStatusUpdated(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SyncStarted value)  syncStarted,required TResult Function( SyncStatusUpdated value)  statusUpdated,required TResult Function( AttachmentStatusUpdated value)  attachmentStatusUpdated,}){
final _that = this;
switch (_that) {
case SyncStarted():
return syncStarted(_that);case SyncStatusUpdated():
return statusUpdated(_that);case AttachmentStatusUpdated():
return attachmentStatusUpdated(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SyncStarted value)?  syncStarted,TResult? Function( SyncStatusUpdated value)?  statusUpdated,TResult? Function( AttachmentStatusUpdated value)?  attachmentStatusUpdated,}){
final _that = this;
switch (_that) {
case SyncStarted() when syncStarted != null:
return syncStarted(_that);case SyncStatusUpdated() when statusUpdated != null:
return statusUpdated(_that);case AttachmentStatusUpdated() when attachmentStatusUpdated != null:
return attachmentStatusUpdated(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  syncStarted,TResult Function( SyncStatus status)?  statusUpdated,TResult Function( bool isDownloading)?  attachmentStatusUpdated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SyncStarted() when syncStarted != null:
return syncStarted();case SyncStatusUpdated() when statusUpdated != null:
return statusUpdated(_that.status);case AttachmentStatusUpdated() when attachmentStatusUpdated != null:
return attachmentStatusUpdated(_that.isDownloading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  syncStarted,required TResult Function( SyncStatus status)  statusUpdated,required TResult Function( bool isDownloading)  attachmentStatusUpdated,}) {final _that = this;
switch (_that) {
case SyncStarted():
return syncStarted();case SyncStatusUpdated():
return statusUpdated(_that.status);case AttachmentStatusUpdated():
return attachmentStatusUpdated(_that.isDownloading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  syncStarted,TResult? Function( SyncStatus status)?  statusUpdated,TResult? Function( bool isDownloading)?  attachmentStatusUpdated,}) {final _that = this;
switch (_that) {
case SyncStarted() when syncStarted != null:
return syncStarted();case SyncStatusUpdated() when statusUpdated != null:
return statusUpdated(_that.status);case AttachmentStatusUpdated() when attachmentStatusUpdated != null:
return attachmentStatusUpdated(_that.isDownloading);case _:
  return null;

}
}

}

/// @nodoc


class SyncStarted implements SyncEvent {
  const SyncStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SyncEvent.syncStarted()';
}


}




/// @nodoc


class SyncStatusUpdated implements SyncEvent {
  const SyncStatusUpdated(this.status);
  

 final  SyncStatus status;

/// Create a copy of SyncEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncStatusUpdatedCopyWith<SyncStatusUpdated> get copyWith => _$SyncStatusUpdatedCopyWithImpl<SyncStatusUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncStatusUpdated&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'SyncEvent.statusUpdated(status: $status)';
}


}

/// @nodoc
abstract mixin class $SyncStatusUpdatedCopyWith<$Res> implements $SyncEventCopyWith<$Res> {
  factory $SyncStatusUpdatedCopyWith(SyncStatusUpdated value, $Res Function(SyncStatusUpdated) _then) = _$SyncStatusUpdatedCopyWithImpl;
@useResult
$Res call({
 SyncStatus status
});




}
/// @nodoc
class _$SyncStatusUpdatedCopyWithImpl<$Res>
    implements $SyncStatusUpdatedCopyWith<$Res> {
  _$SyncStatusUpdatedCopyWithImpl(this._self, this._then);

  final SyncStatusUpdated _self;
  final $Res Function(SyncStatusUpdated) _then;

/// Create a copy of SyncEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? status = null,}) {
  return _then(SyncStatusUpdated(
null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SyncStatus,
  ));
}


}

/// @nodoc


class AttachmentStatusUpdated implements SyncEvent {
  const AttachmentStatusUpdated({required this.isDownloading});
  

 final  bool isDownloading;

/// Create a copy of SyncEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttachmentStatusUpdatedCopyWith<AttachmentStatusUpdated> get copyWith => _$AttachmentStatusUpdatedCopyWithImpl<AttachmentStatusUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttachmentStatusUpdated&&(identical(other.isDownloading, isDownloading) || other.isDownloading == isDownloading));
}


@override
int get hashCode => Object.hash(runtimeType,isDownloading);

@override
String toString() {
  return 'SyncEvent.attachmentStatusUpdated(isDownloading: $isDownloading)';
}


}

/// @nodoc
abstract mixin class $AttachmentStatusUpdatedCopyWith<$Res> implements $SyncEventCopyWith<$Res> {
  factory $AttachmentStatusUpdatedCopyWith(AttachmentStatusUpdated value, $Res Function(AttachmentStatusUpdated) _then) = _$AttachmentStatusUpdatedCopyWithImpl;
@useResult
$Res call({
 bool isDownloading
});




}
/// @nodoc
class _$AttachmentStatusUpdatedCopyWithImpl<$Res>
    implements $AttachmentStatusUpdatedCopyWith<$Res> {
  _$AttachmentStatusUpdatedCopyWithImpl(this._self, this._then);

  final AttachmentStatusUpdated _self;
  final $Res Function(AttachmentStatusUpdated) _then;

/// Create a copy of SyncEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isDownloading = null,}) {
  return _then(AttachmentStatusUpdated(
isDownloading: null == isDownloading ? _self.isDownloading : isDownloading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
