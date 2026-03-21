import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:powersync/powersync.dart';

part 'sync_state.freezed.dart';

@freezed
abstract class SyncState with _$SyncState {
  const factory SyncState({
    SyncStatus? status,
    @Default(false) bool isDownloadingAttachments,
  }) = _SyncState;
}
