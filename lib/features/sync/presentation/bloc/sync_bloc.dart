import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:powersync/powersync.dart';
import 'sync_event.dart';
import 'sync_state.dart';

class SyncBloc extends Bloc<SyncEvent, SyncState> {
  final PowerSyncDatabase _db;
  StreamSubscription<SyncStatus>? _statusSubscription;
  StreamSubscription<bool>? _attachmentSubscription;

  SyncBloc(this._db) : super(const SyncState()) {
    on<SyncEvent>((event, emit) async {
      await event.map(
        syncStarted: (e) async => _onStarted(e, emit),
        statusUpdated: (e) async => _onStatusUpdated(e, emit),
        attachmentStatusUpdated: (e) async => _onAttachmentStatusUpdated(e, emit),
      );
    });
  }

  Future<void> _onStarted(SyncStarted event, Emitter<SyncState> emit) async {
    await _statusSubscription?.cancel();
    
    // Emit initial status
    emit(state.copyWith(status: _db.currentStatus));

    _statusSubscription = _db.statusStream.listen((status) {
      add(SyncEvent.statusUpdated(status));
    });

    _attachmentSubscription = _db
        .watch(
          'SELECT count(*) as count FROM attachments WHERE state = 2',
        )
        .map((results) => (results.first['count'] as int) > 0)
        .listen((isDownloading) {
      add(SyncEvent.attachmentStatusUpdated(isDownloading: isDownloading));
    });
  }

  void _onStatusUpdated(SyncStatusUpdated event, Emitter<SyncState> emit) {
    emit(state.copyWith(status: event.status));
  }

  void _onAttachmentStatusUpdated(
    AttachmentStatusUpdated event,
    Emitter<SyncState> emit,
  ) {
    emit(state.copyWith(isDownloadingAttachments: event.isDownloading));
  }

  @override
  Future<void> close() {
    _statusSubscription?.cancel();
    _attachmentSubscription?.cancel();
    return super.close();
  }
}
