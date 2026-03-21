import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:powersync/powersync.dart';

part 'sync_event.freezed.dart';

@freezed
class SyncEvent with _$SyncEvent {
  const factory SyncEvent.syncStarted() = SyncStarted;
  const factory SyncEvent.statusUpdated(SyncStatus status) = SyncStatusUpdated;
  const factory SyncEvent.attachmentStatusUpdated({required bool isDownloading}) =
      AttachmentStatusUpdated;
}
