// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verify_otp_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VerifyOtpEvent {

 String get email;
/// Create a copy of VerifyOtpEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyOtpEventCopyWith<VerifyOtpEvent> get copyWith => _$VerifyOtpEventCopyWithImpl<VerifyOtpEvent>(this as VerifyOtpEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyOtpEvent&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'VerifyOtpEvent(email: $email)';
}


}

/// @nodoc
abstract mixin class $VerifyOtpEventCopyWith<$Res>  {
  factory $VerifyOtpEventCopyWith(VerifyOtpEvent value, $Res Function(VerifyOtpEvent) _then) = _$VerifyOtpEventCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$VerifyOtpEventCopyWithImpl<$Res>
    implements $VerifyOtpEventCopyWith<$Res> {
  _$VerifyOtpEventCopyWithImpl(this._self, this._then);

  final VerifyOtpEvent _self;
  final $Res Function(VerifyOtpEvent) _then;

/// Create a copy of VerifyOtpEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VerifyOtpEvent].
extension VerifyOtpEventPatterns on VerifyOtpEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _SubmitOtp value)?  submitOtp,TResult Function( _ResendOtp value)?  resendOtp,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubmitOtp() when submitOtp != null:
return submitOtp(_that);case _ResendOtp() when resendOtp != null:
return resendOtp(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _SubmitOtp value)  submitOtp,required TResult Function( _ResendOtp value)  resendOtp,}){
final _that = this;
switch (_that) {
case _SubmitOtp():
return submitOtp(_that);case _ResendOtp():
return resendOtp(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _SubmitOtp value)?  submitOtp,TResult? Function( _ResendOtp value)?  resendOtp,}){
final _that = this;
switch (_that) {
case _SubmitOtp() when submitOtp != null:
return submitOtp(_that);case _ResendOtp() when resendOtp != null:
return resendOtp(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String email,  String token)?  submitOtp,TResult Function( String email)?  resendOtp,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubmitOtp() when submitOtp != null:
return submitOtp(_that.email,_that.token);case _ResendOtp() when resendOtp != null:
return resendOtp(_that.email);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String email,  String token)  submitOtp,required TResult Function( String email)  resendOtp,}) {final _that = this;
switch (_that) {
case _SubmitOtp():
return submitOtp(_that.email,_that.token);case _ResendOtp():
return resendOtp(_that.email);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String email,  String token)?  submitOtp,TResult? Function( String email)?  resendOtp,}) {final _that = this;
switch (_that) {
case _SubmitOtp() when submitOtp != null:
return submitOtp(_that.email,_that.token);case _ResendOtp() when resendOtp != null:
return resendOtp(_that.email);case _:
  return null;

}
}

}

/// @nodoc


class _SubmitOtp implements VerifyOtpEvent {
  const _SubmitOtp({required this.email, required this.token});
  

@override final  String email;
 final  String token;

/// Create a copy of VerifyOtpEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubmitOtpCopyWith<_SubmitOtp> get copyWith => __$SubmitOtpCopyWithImpl<_SubmitOtp>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmitOtp&&(identical(other.email, email) || other.email == email)&&(identical(other.token, token) || other.token == token));
}


@override
int get hashCode => Object.hash(runtimeType,email,token);

@override
String toString() {
  return 'VerifyOtpEvent.submitOtp(email: $email, token: $token)';
}


}

/// @nodoc
abstract mixin class _$SubmitOtpCopyWith<$Res> implements $VerifyOtpEventCopyWith<$Res> {
  factory _$SubmitOtpCopyWith(_SubmitOtp value, $Res Function(_SubmitOtp) _then) = __$SubmitOtpCopyWithImpl;
@override @useResult
$Res call({
 String email, String token
});




}
/// @nodoc
class __$SubmitOtpCopyWithImpl<$Res>
    implements _$SubmitOtpCopyWith<$Res> {
  __$SubmitOtpCopyWithImpl(this._self, this._then);

  final _SubmitOtp _self;
  final $Res Function(_SubmitOtp) _then;

/// Create a copy of VerifyOtpEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? token = null,}) {
  return _then(_SubmitOtp(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ResendOtp implements VerifyOtpEvent {
  const _ResendOtp({required this.email});
  

@override final  String email;

/// Create a copy of VerifyOtpEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResendOtpCopyWith<_ResendOtp> get copyWith => __$ResendOtpCopyWithImpl<_ResendOtp>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResendOtp&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'VerifyOtpEvent.resendOtp(email: $email)';
}


}

/// @nodoc
abstract mixin class _$ResendOtpCopyWith<$Res> implements $VerifyOtpEventCopyWith<$Res> {
  factory _$ResendOtpCopyWith(_ResendOtp value, $Res Function(_ResendOtp) _then) = __$ResendOtpCopyWithImpl;
@override @useResult
$Res call({
 String email
});




}
/// @nodoc
class __$ResendOtpCopyWithImpl<$Res>
    implements _$ResendOtpCopyWith<$Res> {
  __$ResendOtpCopyWithImpl(this._self, this._then);

  final _ResendOtp _self;
  final $Res Function(_ResendOtp) _then;

/// Create a copy of VerifyOtpEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(_ResendOtp(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$VerifyOtpState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyOtpState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VerifyOtpState()';
}


}

/// @nodoc
class $VerifyOtpStateCopyWith<$Res>  {
$VerifyOtpStateCopyWith(VerifyOtpState _, $Res Function(VerifyOtpState) __);
}


/// Adds pattern-matching-related methods to [VerifyOtpState].
extension VerifyOtpStatePatterns on VerifyOtpState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Success value)?  success,TResult Function( _Failure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Failure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Success value)  success,required TResult Function( _Failure value)  failure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Success():
return success(_that);case _Failure():
return failure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Success value)?  success,TResult? Function( _Failure value)?  failure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Failure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  success,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success();case _Failure() when failure != null:
return failure(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  success,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Success():
return success();case _Failure():
return failure(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  success,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success();case _Failure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements VerifyOtpState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VerifyOtpState.initial()';
}


}




/// @nodoc


class _Loading implements VerifyOtpState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VerifyOtpState.loading()';
}


}




/// @nodoc


class _Success implements VerifyOtpState {
  const _Success();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VerifyOtpState.success()';
}


}




/// @nodoc


class _Failure implements VerifyOtpState {
  const _Failure(this.message);
  

 final  String message;

/// Create a copy of VerifyOtpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailureCopyWith<_Failure> get copyWith => __$FailureCopyWithImpl<_Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'VerifyOtpState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $VerifyOtpStateCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) = __$FailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$FailureCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure _self;
  final $Res Function(_Failure) _then;

/// Create a copy of VerifyOtpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Failure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
