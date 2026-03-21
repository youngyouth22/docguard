// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DocumentState {

 DocumentSyncStatus get status; List<DocumentEntity> get documents; List<DocumentEntity> get favoriteDocuments; List<CategoryEntity> get categories; Map<String, bool> get aiProcessingStates;// documentId -> isProcessing
 String? get errorMessage;
/// Create a copy of DocumentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentStateCopyWith<DocumentState> get copyWith => _$DocumentStateCopyWithImpl<DocumentState>(this as DocumentState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.documents, documents)&&const DeepCollectionEquality().equals(other.favoriteDocuments, favoriteDocuments)&&const DeepCollectionEquality().equals(other.categories, categories)&&const DeepCollectionEquality().equals(other.aiProcessingStates, aiProcessingStates)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(documents),const DeepCollectionEquality().hash(favoriteDocuments),const DeepCollectionEquality().hash(categories),const DeepCollectionEquality().hash(aiProcessingStates),errorMessage);

@override
String toString() {
  return 'DocumentState(status: $status, documents: $documents, favoriteDocuments: $favoriteDocuments, categories: $categories, aiProcessingStates: $aiProcessingStates, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $DocumentStateCopyWith<$Res>  {
  factory $DocumentStateCopyWith(DocumentState value, $Res Function(DocumentState) _then) = _$DocumentStateCopyWithImpl;
@useResult
$Res call({
 DocumentSyncStatus status, List<DocumentEntity> documents, List<DocumentEntity> favoriteDocuments, List<CategoryEntity> categories, Map<String, bool> aiProcessingStates, String? errorMessage
});




}
/// @nodoc
class _$DocumentStateCopyWithImpl<$Res>
    implements $DocumentStateCopyWith<$Res> {
  _$DocumentStateCopyWithImpl(this._self, this._then);

  final DocumentState _self;
  final $Res Function(DocumentState) _then;

/// Create a copy of DocumentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? documents = null,Object? favoriteDocuments = null,Object? categories = null,Object? aiProcessingStates = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DocumentSyncStatus,documents: null == documents ? _self.documents : documents // ignore: cast_nullable_to_non_nullable
as List<DocumentEntity>,favoriteDocuments: null == favoriteDocuments ? _self.favoriteDocuments : favoriteDocuments // ignore: cast_nullable_to_non_nullable
as List<DocumentEntity>,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryEntity>,aiProcessingStates: null == aiProcessingStates ? _self.aiProcessingStates : aiProcessingStates // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DocumentState].
extension DocumentStatePatterns on DocumentState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( DocumentStateImpl value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case DocumentStateImpl() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( DocumentStateImpl value)  $default,){
final _that = this;
switch (_that) {
case DocumentStateImpl():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( DocumentStateImpl value)?  $default,){
final _that = this;
switch (_that) {
case DocumentStateImpl() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DocumentSyncStatus status,  List<DocumentEntity> documents,  List<DocumentEntity> favoriteDocuments,  List<CategoryEntity> categories,  Map<String, bool> aiProcessingStates,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case DocumentStateImpl() when $default != null:
return $default(_that.status,_that.documents,_that.favoriteDocuments,_that.categories,_that.aiProcessingStates,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DocumentSyncStatus status,  List<DocumentEntity> documents,  List<DocumentEntity> favoriteDocuments,  List<CategoryEntity> categories,  Map<String, bool> aiProcessingStates,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case DocumentStateImpl():
return $default(_that.status,_that.documents,_that.favoriteDocuments,_that.categories,_that.aiProcessingStates,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DocumentSyncStatus status,  List<DocumentEntity> documents,  List<DocumentEntity> favoriteDocuments,  List<CategoryEntity> categories,  Map<String, bool> aiProcessingStates,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case DocumentStateImpl() when $default != null:
return $default(_that.status,_that.documents,_that.favoriteDocuments,_that.categories,_that.aiProcessingStates,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class DocumentStateImpl implements DocumentState {
  const DocumentStateImpl({this.status = DocumentSyncStatus.initial, final  List<DocumentEntity> documents = const [], final  List<DocumentEntity> favoriteDocuments = const [], final  List<CategoryEntity> categories = const [], final  Map<String, bool> aiProcessingStates = const {}, this.errorMessage}): _documents = documents,_favoriteDocuments = favoriteDocuments,_categories = categories,_aiProcessingStates = aiProcessingStates;
  

@override@JsonKey() final  DocumentSyncStatus status;
 final  List<DocumentEntity> _documents;
@override@JsonKey() List<DocumentEntity> get documents {
  if (_documents is EqualUnmodifiableListView) return _documents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_documents);
}

 final  List<DocumentEntity> _favoriteDocuments;
@override@JsonKey() List<DocumentEntity> get favoriteDocuments {
  if (_favoriteDocuments is EqualUnmodifiableListView) return _favoriteDocuments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_favoriteDocuments);
}

 final  List<CategoryEntity> _categories;
@override@JsonKey() List<CategoryEntity> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

 final  Map<String, bool> _aiProcessingStates;
@override@JsonKey() Map<String, bool> get aiProcessingStates {
  if (_aiProcessingStates is EqualUnmodifiableMapView) return _aiProcessingStates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_aiProcessingStates);
}

// documentId -> isProcessing
@override final  String? errorMessage;

/// Create a copy of DocumentState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentStateImplCopyWith<DocumentStateImpl> get copyWith => _$DocumentStateImplCopyWithImpl<DocumentStateImpl>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentStateImpl&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._documents, _documents)&&const DeepCollectionEquality().equals(other._favoriteDocuments, _favoriteDocuments)&&const DeepCollectionEquality().equals(other._categories, _categories)&&const DeepCollectionEquality().equals(other._aiProcessingStates, _aiProcessingStates)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_documents),const DeepCollectionEquality().hash(_favoriteDocuments),const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_aiProcessingStates),errorMessage);

@override
String toString() {
  return 'DocumentState(status: $status, documents: $documents, favoriteDocuments: $favoriteDocuments, categories: $categories, aiProcessingStates: $aiProcessingStates, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $DocumentStateImplCopyWith<$Res> implements $DocumentStateCopyWith<$Res> {
  factory $DocumentStateImplCopyWith(DocumentStateImpl value, $Res Function(DocumentStateImpl) _then) = _$DocumentStateImplCopyWithImpl;
@override @useResult
$Res call({
 DocumentSyncStatus status, List<DocumentEntity> documents, List<DocumentEntity> favoriteDocuments, List<CategoryEntity> categories, Map<String, bool> aiProcessingStates, String? errorMessage
});




}
/// @nodoc
class _$DocumentStateImplCopyWithImpl<$Res>
    implements $DocumentStateImplCopyWith<$Res> {
  _$DocumentStateImplCopyWithImpl(this._self, this._then);

  final DocumentStateImpl _self;
  final $Res Function(DocumentStateImpl) _then;

/// Create a copy of DocumentState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? documents = null,Object? favoriteDocuments = null,Object? categories = null,Object? aiProcessingStates = null,Object? errorMessage = freezed,}) {
  return _then(DocumentStateImpl(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DocumentSyncStatus,documents: null == documents ? _self._documents : documents // ignore: cast_nullable_to_non_nullable
as List<DocumentEntity>,favoriteDocuments: null == favoriteDocuments ? _self._favoriteDocuments : favoriteDocuments // ignore: cast_nullable_to_non_nullable
as List<DocumentEntity>,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryEntity>,aiProcessingStates: null == aiProcessingStates ? _self._aiProcessingStates : aiProcessingStates // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
