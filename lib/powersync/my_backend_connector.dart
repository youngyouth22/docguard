import 'dart:io';
import 'package:docguard/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:powersync/powersync.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:logging/logging.dart';

final log = Logger('powersync-supabase');

/// Postgres Response codes that we cannot recover from by retrying.
final List<RegExp> fatalResponseCodes = [
  // Class 22 — Data Exception
  // Examples include data type mismatch.
  RegExp(r'^22...$'),
  // Class 23 — Integrity Constraint Violation.
  // Examples include NOT NULL, FOREIGN KEY and UNIQUE violations.
  RegExp(r'^23...$'),
  // INSUFFICIENT PRIVILEGE - typically a row-level security violation
  RegExp(r'^42501$'),
];

/// Use Supabase for authentication and data upload.
class MyBackendConnector extends PowerSyncBackendConnector {
  PowerSyncDatabase db;

  Future<void>? _refreshFuture;

  MyBackendConnector(this.db);

  /// Get a Supabase token to authenticate against the PowerSync instance.
  @override
  Future<PowerSyncCredentials?> fetchCredentials() async {
    try {
      // Wait for pending session refresh if any
      await _refreshFuture;

      // Use Supabase token for PowerSync
      final session = getIt<SupabaseClient>().auth.currentSession;

      if (session == null) {
        debugPrint('❌ No session - user not logged in');
        // Not logged in
        return null;
      }

      // Use the access token to authenticate against PowerSync
      final token = session.accessToken;

      // userId and expiresAt are for debugging purposes only
      final userId = session.user.id;
      final expiresAt = session.expiresAt == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(session.expiresAt! * 1000);

      debugPrint('✅ Credentials:');
      debugPrint('   User ID: $userId');
      debugPrint('   Token length: ${token.length}');
      debugPrint('   Expires at: $expiresAt');

      return PowerSyncCredentials(
        endpoint: dotenv.env['POWER_SYNC_ENDPOINT']!,
        token: token,
        userId: userId,
        expiresAt: expiresAt,
      );
    } on SocketException catch (_) {
      return null;
    } catch (e, stackTrace) {
      debugPrint('💥 Error fetching credentials: $e');
      debugPrint('Stack trace: $stackTrace');
      rethrow;
    }
  }

  @override
  void invalidateCredentials() {
    // Trigger a session refresh if auth fails on PowerSync.
    // Generally, sessions should be refreshed automatically by Supabase.
    // However, in some cases it can be a while before the session refresh is
    // retried. We attempt to trigger the refresh as soon as we get an auth
    // failure on PowerSync.
    //
    // This could happen if the device was offline for a while and the session
    // expired, and nothing else attempt to use the session it in the meantime.
    //
    // Timeout the refresh call to avoid waiting for long retries,
    // and ignore any errors. Errors will surface as expired tokens.
    _refreshFuture = getIt<SupabaseClient>().auth
        .refreshSession()
        .timeout(const Duration(seconds: 5))
        .then((response) => null, onError: (error) => null);
  }

  // Upload pending changes to Supabase.
  @override
  Future<void> uploadData(PowerSyncDatabase database) async {
    final transaction = await database.getNextCrudTransaction();
    if (transaction == null) {
      return;
    }

    debugPrint(
      '📤 Starting upload transaction with ${transaction.crud.length} operations',
    );

    final rest = Supabase.instance.client.rest;
    CrudEntry? lastOp;
    try {
      for (var op in transaction.crud) {
        lastOp = op;

        // Add detailed logging for each operation
        debugPrint('📤 Uploading: ${op.op} on ${op.table} with id: ${op.id}');
        debugPrint('   Data: ${op.opData}');

        final table = rest.from(op.table);
        if (op.op == UpdateType.put) {
          var data = Map<String, dynamic>.of(op.opData!);
          data['id'] = op.id;
          await table.upsert(data);
          debugPrint('✅ PUT successful for ${op.table}/${op.id}');
        } else if (op.op == UpdateType.patch) {
          await table.update(op.opData!).eq('id', op.id);
          debugPrint('✅ PATCH successful for ${op.table}/${op.id}');
        } else if (op.op == UpdateType.delete) {
          await table.delete().eq('id', op.id);
          debugPrint('✅ DELETE successful for ${op.table}/${op.id}');
        }
      }

      // All operations successful
      await transaction.complete();
      debugPrint('✅ Transaction completed successfully');
    } on PostgrestException catch (e) {
      debugPrint('❌ PostgrestException during upload: ${e.message}');
      debugPrint('   Code: ${e.code}');
      debugPrint('   Details: ${e.details}');
      debugPrint('   Failed operation: $lastOp');

      if (e.code != null &&
          fatalResponseCodes.any((re) => re.hasMatch(e.code!))) {
        /// Instead of blocking the queue with these errors,
        /// discard the (rest of the) transaction.
        ///
        /// Note that these errors typically indicate a bug in the application.
        /// If protecting against data loss is important, save the failing records
        /// elsewhere instead of discarding, and/or notify the user.
        log.severe('Data upload error - discarding $lastOp', e);
        await transaction.complete();
        debugPrint('⚠️ Fatal error - transaction discarded');
      } else {
        // Error may be retryable - e.g. network error or temporary server error.
        // Throwing an error here causes this call to be retried after a delay.
        debugPrint('⚠️ Retryable error - will retry later');
        rethrow;
      }
    } catch (e) {
      debugPrint('❌ Unexpected error during upload: $e');
      debugPrint('   Failed operation: $lastOp');
      rethrow;
    }
  }
}
