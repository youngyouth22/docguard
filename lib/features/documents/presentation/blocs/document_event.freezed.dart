// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DocumentEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DocumentEvent()';
}


}

/// @nodoc
class $DocumentEventCopyWith<$Res>  {
$DocumentEventCopyWith(DocumentEvent _, $Res Function(DocumentEvent) __);
}


/// Adds pattern-matching-related methods to [DocumentEvent].
extension DocumentEventPatterns on DocumentEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Started value)?  started,TResult Function( UploadRequested value)?  uploadRequested,TResult Function( DocumentsUpdated value)?  documentsUpdated,TResult Function( FavoriteDocumentsUpdated value)?  favoriteDocumentsUpdated,TResult Function( CategoriesUpdated value)?  categoriesUpdated,TResult Function( ScannedDocumentUploadRequested value)?  scannedDocumentUploadRequested,TResult Function( FavoriteToggled value)?  favoriteToggled,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case UploadRequested() when uploadRequested != null:
return uploadRequested(_that);case DocumentsUpdated() when documentsUpdated != null:
return documentsUpdated(_that);case FavoriteDocumentsUpdated() when favoriteDocumentsUpdated != null:
return favoriteDocumentsUpdated(_that);case CategoriesUpdated() when categoriesUpdated != null:
return categoriesUpdated(_that);case ScannedDocumentUploadRequested() when scannedDocumentUploadRequested != null:
return scannedDocumentUploadRequested(_that);case FavoriteToggled() when favoriteToggled != null:
return favoriteToggled(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Started value)  started,required TResult Function( UploadRequested value)  uploadRequested,required TResult Function( DocumentsUpdated value)  documentsUpdated,required TResult Function( FavoriteDocumentsUpdated value)  favoriteDocumentsUpdated,required TResult Function( CategoriesUpdated value)  categoriesUpdated,required TResult Function( ScannedDocumentUploadRequested value)  scannedDocumentUploadRequested,required TResult Function( FavoriteToggled value)  favoriteToggled,}){
final _that = this;
switch (_that) {
case Started():
return started(_that);case UploadRequested():
return uploadRequested(_that);case DocumentsUpdated():
return documentsUpdated(_that);case FavoriteDocumentsUpdated():
return favoriteDocumentsUpdated(_that);case CategoriesUpdated():
return categoriesUpdated(_that);case ScannedDocumentUploadRequested():
return scannedDocumentUploadRequested(_that);case FavoriteToggled():
return favoriteToggled(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Started value)?  started,TResult? Function( UploadRequested value)?  uploadRequested,TResult? Function( DocumentsUpdated value)?  documentsUpdated,TResult? Function( FavoriteDocumentsUpdated value)?  favoriteDocumentsUpdated,TResult? Function( CategoriesUpdated value)?  categoriesUpdated,TResult? Function( ScannedDocumentUploadRequested value)?  scannedDocumentUploadRequested,TResult? Function( FavoriteToggled value)?  favoriteToggled,}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case UploadRequested() when uploadRequested != null:
return uploadRequested(_that);case DocumentsUpdated() when documentsUpdated != null:
return documentsUpdated(_that);case FavoriteDocumentsUpdated() when favoriteDocumentsUpdated != null:
return favoriteDocumentsUpdated(_that);case CategoriesUpdated() when categoriesUpdated != null:
return categoriesUpdated(_that);case ScannedDocumentUploadRequested() when scannedDocumentUploadRequested != null:
return scannedDocumentUploadRequested(_that);case FavoriteToggled() when favoriteToggled != null:
return favoriteToggled(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String filePath,  String categoryId,  String ownerFullName,  String docNumber,  String? description,  String? city,  String? neighborhood,  String? countryCode,  String? reportType)?  uploadRequested,TResult Function( List<DocumentEntity> documents)?  documentsUpdated,TResult Function( List<DocumentEntity> favoriteDocuments)?  favoriteDocumentsUpdated,TResult Function( List<CategoryEntity> categories)?  categoriesUpdated,TResult Function( String filePath)?  scannedDocumentUploadRequested,TResult Function( String documentId,  bool isFavorite)?  favoriteToggled,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started();case UploadRequested() when uploadRequested != null:
return uploadRequested(_that.filePath,_that.categoryId,_that.ownerFullName,_that.docNumber,_that.description,_that.city,_that.neighborhood,_that.countryCode,_that.reportType);case DocumentsUpdated() when documentsUpdated != null:
return documentsUpdated(_that.documents);case FavoriteDocumentsUpdated() when favoriteDocumentsUpdated != null:
return favoriteDocumentsUpdated(_that.favoriteDocuments);case CategoriesUpdated() when categoriesUpdated != null:
return categoriesUpdated(_that.categories);case ScannedDocumentUploadRequested() when scannedDocumentUploadRequested != null:
return scannedDocumentUploadRequested(_that.filePath);case FavoriteToggled() when favoriteToggled != null:
return favoriteToggled(_that.documentId,_that.isFavorite);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String filePath,  String categoryId,  String ownerFullName,  String docNumber,  String? description,  String? city,  String? neighborhood,  String? countryCode,  String? reportType)  uploadRequested,required TResult Function( List<DocumentEntity> documents)  documentsUpdated,required TResult Function( List<DocumentEntity> favoriteDocuments)  favoriteDocumentsUpdated,required TResult Function( List<CategoryEntity> categories)  categoriesUpdated,required TResult Function( String filePath)  scannedDocumentUploadRequested,required TResult Function( String documentId,  bool isFavorite)  favoriteToggled,}) {final _that = this;
switch (_that) {
case Started():
return started();case UploadRequested():
return uploadRequested(_that.filePath,_that.categoryId,_that.ownerFullName,_that.docNumber,_that.description,_that.city,_that.neighborhood,_that.countryCode,_that.reportType);case DocumentsUpdated():
return documentsUpdated(_that.documents);case FavoriteDocumentsUpdated():
return favoriteDocumentsUpdated(_that.favoriteDocuments);case CategoriesUpdated():
return categoriesUpdated(_that.categories);case ScannedDocumentUploadRequested():
return scannedDocumentUploadRequested(_that.filePath);case FavoriteToggled():
return favoriteToggled(_that.documentId,_that.isFavorite);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String filePath,  String categoryId,  String ownerFullName,  String docNumber,  String? description,  String? city,  String? neighborhood,  String? countryCode,  String? reportType)?  uploadRequested,TResult? Function( List<DocumentEntity> documents)?  documentsUpdated,TResult? Function( List<DocumentEntity> favoriteDocuments)?  favoriteDocumentsUpdated,TResult? Function( List<CategoryEntity> categories)?  categoriesUpdated,TResult? Function( String filePath)?  scannedDocumentUploadRequested,TResult? Function( String documentId,  bool isFavorite)?  favoriteToggled,}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started();case UploadRequested() when uploadRequested != null:
return uploadRequested(_that.filePath,_that.categoryId,_that.ownerFullName,_that.docNumber,_that.description,_that.city,_that.neighborhood,_that.countryCode,_that.reportType);case DocumentsUpdated() when documentsUpdated != null:
return documentsUpdated(_that.documents);case FavoriteDocumentsUpdated() when favoriteDocumentsUpdated != null:
return favoriteDocumentsUpdated(_that.favoriteDocuments);case CategoriesUpdated() when categoriesUpdated != null:
return categoriesUpdated(_that.categories);case ScannedDocumentUploadRequested() when scannedDocumentUploadRequested != null:
return scannedDocumentUploadRequested(_that.filePath);case FavoriteToggled() when favoriteToggled != null:
return favoriteToggled(_that.documentId,_that.isFavorite);case _:
  return null;

}
}

}

/// @nodoc


class Started implements DocumentEvent {
  const Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DocumentEvent.started()';
}


}




/// @nodoc


class UploadRequested implements DocumentEvent {
  const UploadRequested({required this.filePath, required this.categoryId, required this.ownerFullName, required this.docNumber, this.description, this.city, this.neighborhood, this.countryCode, this.reportType});
  

 final  String filePath;
 final  String categoryId;
 final  String ownerFullName;
 final  String docNumber;
 final  String? description;
 final  String? city;
 final  String? neighborhood;
 final  String? countryCode;
 final  String? reportType;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UploadRequestedCopyWith<UploadRequested> get copyWith => _$UploadRequestedCopyWithImpl<UploadRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UploadRequested&&(identical(other.filePath, filePath) || other.filePath == filePath)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.ownerFullName, ownerFullName) || other.ownerFullName == ownerFullName)&&(identical(other.docNumber, docNumber) || other.docNumber == docNumber)&&(identical(other.description, description) || other.description == description)&&(identical(other.city, city) || other.city == city)&&(identical(other.neighborhood, neighborhood) || other.neighborhood == neighborhood)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.reportType, reportType) || other.reportType == reportType));
}


@override
int get hashCode => Object.hash(runtimeType,filePath,categoryId,ownerFullName,docNumber,description,city,neighborhood,countryCode,reportType);

@override
String toString() {
  return 'DocumentEvent.uploadRequested(filePath: $filePath, categoryId: $categoryId, ownerFullName: $ownerFullName, docNumber: $docNumber, description: $description, city: $city, neighborhood: $neighborhood, countryCode: $countryCode, reportType: $reportType)';
}


}

/// @nodoc
abstract mixin class $UploadRequestedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $UploadRequestedCopyWith(UploadRequested value, $Res Function(UploadRequested) _then) = _$UploadRequestedCopyWithImpl;
@useResult
$Res call({
 String filePath, String categoryId, String ownerFullName, String docNumber, String? description, String? city, String? neighborhood, String? countryCode, String? reportType
});




}
/// @nodoc
class _$UploadRequestedCopyWithImpl<$Res>
    implements $UploadRequestedCopyWith<$Res> {
  _$UploadRequestedCopyWithImpl(this._self, this._then);

  final UploadRequested _self;
  final $Res Function(UploadRequested) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filePath = null,Object? categoryId = null,Object? ownerFullName = null,Object? docNumber = null,Object? description = freezed,Object? city = freezed,Object? neighborhood = freezed,Object? countryCode = freezed,Object? reportType = freezed,}) {
  return _then(UploadRequested(
filePath: null == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,ownerFullName: null == ownerFullName ? _self.ownerFullName : ownerFullName // ignore: cast_nullable_to_non_nullable
as String,docNumber: null == docNumber ? _self.docNumber : docNumber // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,neighborhood: freezed == neighborhood ? _self.neighborhood : neighborhood // ignore: cast_nullable_to_non_nullable
as String?,countryCode: freezed == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String?,reportType: freezed == reportType ? _self.reportType : reportType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class DocumentsUpdated implements DocumentEvent {
  const DocumentsUpdated(final  List<DocumentEntity> documents): _documents = documents;
  

 final  List<DocumentEntity> _documents;
 List<DocumentEntity> get documents {
  if (_documents is EqualUnmodifiableListView) return _documents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_documents);
}


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentsUpdatedCopyWith<DocumentsUpdated> get copyWith => _$DocumentsUpdatedCopyWithImpl<DocumentsUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentsUpdated&&const DeepCollectionEquality().equals(other._documents, _documents));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_documents));

@override
String toString() {
  return 'DocumentEvent.documentsUpdated(documents: $documents)';
}


}

/// @nodoc
abstract mixin class $DocumentsUpdatedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $DocumentsUpdatedCopyWith(DocumentsUpdated value, $Res Function(DocumentsUpdated) _then) = _$DocumentsUpdatedCopyWithImpl;
@useResult
$Res call({
 List<DocumentEntity> documents
});




}
/// @nodoc
class _$DocumentsUpdatedCopyWithImpl<$Res>
    implements $DocumentsUpdatedCopyWith<$Res> {
  _$DocumentsUpdatedCopyWithImpl(this._self, this._then);

  final DocumentsUpdated _self;
  final $Res Function(DocumentsUpdated) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? documents = null,}) {
  return _then(DocumentsUpdated(
null == documents ? _self._documents : documents // ignore: cast_nullable_to_non_nullable
as List<DocumentEntity>,
  ));
}


}

/// @nodoc


class FavoriteDocumentsUpdated implements DocumentEvent {
  const FavoriteDocumentsUpdated(final  List<DocumentEntity> favoriteDocuments): _favoriteDocuments = favoriteDocuments;
  

 final  List<DocumentEntity> _favoriteDocuments;
 List<DocumentEntity> get favoriteDocuments {
  if (_favoriteDocuments is EqualUnmodifiableListView) return _favoriteDocuments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_favoriteDocuments);
}


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoriteDocumentsUpdatedCopyWith<FavoriteDocumentsUpdated> get copyWith => _$FavoriteDocumentsUpdatedCopyWithImpl<FavoriteDocumentsUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoriteDocumentsUpdated&&const DeepCollectionEquality().equals(other._favoriteDocuments, _favoriteDocuments));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_favoriteDocuments));

@override
String toString() {
  return 'DocumentEvent.favoriteDocumentsUpdated(favoriteDocuments: $favoriteDocuments)';
}


}

/// @nodoc
abstract mixin class $FavoriteDocumentsUpdatedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $FavoriteDocumentsUpdatedCopyWith(FavoriteDocumentsUpdated value, $Res Function(FavoriteDocumentsUpdated) _then) = _$FavoriteDocumentsUpdatedCopyWithImpl;
@useResult
$Res call({
 List<DocumentEntity> favoriteDocuments
});




}
/// @nodoc
class _$FavoriteDocumentsUpdatedCopyWithImpl<$Res>
    implements $FavoriteDocumentsUpdatedCopyWith<$Res> {
  _$FavoriteDocumentsUpdatedCopyWithImpl(this._self, this._then);

  final FavoriteDocumentsUpdated _self;
  final $Res Function(FavoriteDocumentsUpdated) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? favoriteDocuments = null,}) {
  return _then(FavoriteDocumentsUpdated(
null == favoriteDocuments ? _self._favoriteDocuments : favoriteDocuments // ignore: cast_nullable_to_non_nullable
as List<DocumentEntity>,
  ));
}


}

/// @nodoc


class CategoriesUpdated implements DocumentEvent {
  const CategoriesUpdated(final  List<CategoryEntity> categories): _categories = categories;
  

 final  List<CategoryEntity> _categories;
 List<CategoryEntity> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoriesUpdatedCopyWith<CategoriesUpdated> get copyWith => _$CategoriesUpdatedCopyWithImpl<CategoriesUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoriesUpdated&&const DeepCollectionEquality().equals(other._categories, _categories));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_categories));

@override
String toString() {
  return 'DocumentEvent.categoriesUpdated(categories: $categories)';
}


}

/// @nodoc
abstract mixin class $CategoriesUpdatedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $CategoriesUpdatedCopyWith(CategoriesUpdated value, $Res Function(CategoriesUpdated) _then) = _$CategoriesUpdatedCopyWithImpl;
@useResult
$Res call({
 List<CategoryEntity> categories
});




}
/// @nodoc
class _$CategoriesUpdatedCopyWithImpl<$Res>
    implements $CategoriesUpdatedCopyWith<$Res> {
  _$CategoriesUpdatedCopyWithImpl(this._self, this._then);

  final CategoriesUpdated _self;
  final $Res Function(CategoriesUpdated) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? categories = null,}) {
  return _then(CategoriesUpdated(
null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryEntity>,
  ));
}


}

/// @nodoc


class ScannedDocumentUploadRequested implements DocumentEvent {
  const ScannedDocumentUploadRequested(this.filePath);
  

 final  String filePath;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScannedDocumentUploadRequestedCopyWith<ScannedDocumentUploadRequested> get copyWith => _$ScannedDocumentUploadRequestedCopyWithImpl<ScannedDocumentUploadRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScannedDocumentUploadRequested&&(identical(other.filePath, filePath) || other.filePath == filePath));
}


@override
int get hashCode => Object.hash(runtimeType,filePath);

@override
String toString() {
  return 'DocumentEvent.scannedDocumentUploadRequested(filePath: $filePath)';
}


}

/// @nodoc
abstract mixin class $ScannedDocumentUploadRequestedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $ScannedDocumentUploadRequestedCopyWith(ScannedDocumentUploadRequested value, $Res Function(ScannedDocumentUploadRequested) _then) = _$ScannedDocumentUploadRequestedCopyWithImpl;
@useResult
$Res call({
 String filePath
});




}
/// @nodoc
class _$ScannedDocumentUploadRequestedCopyWithImpl<$Res>
    implements $ScannedDocumentUploadRequestedCopyWith<$Res> {
  _$ScannedDocumentUploadRequestedCopyWithImpl(this._self, this._then);

  final ScannedDocumentUploadRequested _self;
  final $Res Function(ScannedDocumentUploadRequested) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filePath = null,}) {
  return _then(ScannedDocumentUploadRequested(
null == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class FavoriteToggled implements DocumentEvent {
  const FavoriteToggled(this.documentId, this.isFavorite);
  

 final  String documentId;
 final  bool isFavorite;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoriteToggledCopyWith<FavoriteToggled> get copyWith => _$FavoriteToggledCopyWithImpl<FavoriteToggled>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoriteToggled&&(identical(other.documentId, documentId) || other.documentId == documentId)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite));
}


@override
int get hashCode => Object.hash(runtimeType,documentId,isFavorite);

@override
String toString() {
  return 'DocumentEvent.favoriteToggled(documentId: $documentId, isFavorite: $isFavorite)';
}


}

/// @nodoc
abstract mixin class $FavoriteToggledCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $FavoriteToggledCopyWith(FavoriteToggled value, $Res Function(FavoriteToggled) _then) = _$FavoriteToggledCopyWithImpl;
@useResult
$Res call({
 String documentId, bool isFavorite
});




}
/// @nodoc
class _$FavoriteToggledCopyWithImpl<$Res>
    implements $FavoriteToggledCopyWith<$Res> {
  _$FavoriteToggledCopyWithImpl(this._self, this._then);

  final FavoriteToggled _self;
  final $Res Function(FavoriteToggled) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? documentId = null,Object? isFavorite = null,}) {
  return _then(FavoriteToggled(
null == documentId ? _self.documentId : documentId // ignore: cast_nullable_to_non_nullable
as String,null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
