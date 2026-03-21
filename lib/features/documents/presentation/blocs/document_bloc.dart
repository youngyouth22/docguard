import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:docguard/features/documents/domain/usecases/upload_and_sync_document_use_case.dart';
import 'package:docguard/features/documents/domain/usecases/upload_scanned_document_use_case.dart';
import 'package:docguard/features/documents/domain/usecases/watch_user_documents_use_case.dart';
import 'package:docguard/features/documents/domain/usecases/toggle_favorite_use_case.dart';
import 'package:docguard/features/documents/domain/usecases/watch_favorite_documents_use_case.dart';
import 'package:docguard/features/documents/domain/usecases/watch_categories_use_case.dart';
import 'package:docguard/features/documents/presentation/blocs/document_event.dart';
import 'package:docguard/features/documents/presentation/blocs/document_state.dart';

class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  final UploadAndSyncDocumentUseCase _uploadUseCase;
  final UploadScannedDocumentUseCase _uploadScannedUseCase;
  final WatchUserDocumentsUseCase _watchUseCase;
  final WatchFavoriteDocumentsUseCase _watchFavoriteUseCase;
  final ToggleFavoriteUseCase _toggleFavoriteUseCase;
  final WatchCategoriesUseCase _watchCategoriesUseCase;
  StreamSubscription? _documentsSubscription;
  StreamSubscription? _favoriteDocumentsSubscription;
  StreamSubscription? _categoriesSubscription;

  DocumentBloc({
    required UploadAndSyncDocumentUseCase uploadUseCase,
    required UploadScannedDocumentUseCase uploadScannedUseCase,
    required WatchUserDocumentsUseCase watchUseCase,
    required WatchFavoriteDocumentsUseCase watchFavoriteUseCase,
    required ToggleFavoriteUseCase toggleFavoriteUseCase,
    required WatchCategoriesUseCase watchCategoriesUseCase,
  }) : _uploadUseCase = uploadUseCase,
       _uploadScannedUseCase = uploadScannedUseCase,
       _watchUseCase = watchUseCase,
       _watchFavoriteUseCase = watchFavoriteUseCase,
       _toggleFavoriteUseCase = toggleFavoriteUseCase,
       _watchCategoriesUseCase = watchCategoriesUseCase,
       super(const DocumentState()) {
    on<DocumentEvent>((event, emit) async {
      await event.map(
        started: (e) async => _onStarted(e, emit),
        uploadRequested: (e) async => _onUploadRequested(e, emit),
        documentsUpdated: (e) async => _onDocumentsUpdated(e, emit),
        favoriteDocumentsUpdated: (e) async => _onFavoriteDocumentsUpdated(e, emit),
        categoriesUpdated: (e) async => _onCategoriesUpdated(e, emit),
        favoriteToggled: (e) async => _onFavoriteToggled(e, emit),
        scannedDocumentUploadRequested:
            (e) async => _onScannedDocumentUploadRequested(e, emit),
      );
    });
  }

  Future<void> _onStarted(Started event, Emitter<DocumentState> emit) async {
    await _documentsSubscription?.cancel();
    _documentsSubscription = _watchUseCase().listen((documents) {
      add(DocumentEvent.documentsUpdated(documents));
    });
    
    await _favoriteDocumentsSubscription?.cancel();
    _favoriteDocumentsSubscription = _watchFavoriteUseCase().listen((documents) {
      add(DocumentEvent.favoriteDocumentsUpdated(documents));
    });

    await _categoriesSubscription?.cancel();
    _categoriesSubscription = _watchCategoriesUseCase().listen((categories) {
      add(DocumentEvent.categoriesUpdated(categories));
    });
  }

  Future<void> _onUploadRequested(
    UploadRequested event,
    Emitter<DocumentState> emit,
  ) async {
    emit(state.copyWith(status: DocumentSyncStatus.inProgress));

    final result = await _uploadUseCase(
      UploadAndSyncDocumentParams(
        filePath: event.filePath,
        categoryId: event.categoryId,
        ownerFullName: event.ownerFullName,
        docNumber: event.docNumber,
        description: event.description,
        city: event.city,
        neighborhood: event.neighborhood,
        countryCode: event.countryCode,
        reportType: event.reportType,
      ),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: DocumentSyncStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (document) => emit(state.copyWith(status: DocumentSyncStatus.success)),
    );
  }

  Future<void> _onScannedDocumentUploadRequested(
    ScannedDocumentUploadRequested event,
    Emitter<DocumentState> emit,
  ) async {
    emit(state.copyWith(status: DocumentSyncStatus.inProgress));

    final result = await _uploadScannedUseCase(filePath: event.filePath);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: DocumentSyncStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (document) => emit(state.copyWith(status: DocumentSyncStatus.success)),
    );
  }

  void _onDocumentsUpdated(
    DocumentsUpdated event,
    Emitter<DocumentState> emit,
  ) {
    // Determine AI processing states
    final processingStates = <String, bool>{};
    for (final doc in event.documents) {
      // Logic: processing if not aiProcessed OR if fileUrlWord is missing (assuming it's expected)
      // The user said: based on ai_processed and file_url_word availability
      final isProcessing =
          !doc.aiProcessed || (doc.fileUrlWord == null && doc.aiProcessed);
      processingStates[doc.id] = isProcessing;
    }

    emit(
      state.copyWith(
        documents: event.documents,
        aiProcessingStates: processingStates,
      ),
    );
  }

  void _onFavoriteDocumentsUpdated(
    FavoriteDocumentsUpdated event,
    Emitter<DocumentState> emit,
  ) {
    emit(state.copyWith(favoriteDocuments: event.favoriteDocuments));
  }

  void _onCategoriesUpdated(
    CategoriesUpdated event,
    Emitter<DocumentState> emit,
  ) {
    emit(state.copyWith(categories: event.categories));
  }

  Future<void> _onFavoriteToggled(
    FavoriteToggled event,
    Emitter<DocumentState> emit,
  ) async {
    await _toggleFavoriteUseCase(
      documentId: event.documentId,
      isFavorite: event.isFavorite,
    );
  }

  @override
  Future<void> close() {
    _documentsSubscription?.cancel();
    _favoriteDocumentsSubscription?.cancel();
    _categoriesSubscription?.cancel();
    return super.close();
  }
}
