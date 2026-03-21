import 'package:docguard/core/models/schema.dart';
import 'package:docguard/di/injection.dart';
import 'package:docguard/powersync/my_backend_connector.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:powersync/powersync.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<String> getDatabasePath() async {
  const dbFilename = 'docguard-powersync.db';
  if (kIsWeb) {
    return dbFilename;
  }
  final dir = await getApplicationSupportDirectory();
  return join(dir.path, dbFilename);
}

/// Initialize and return a ready-to-use PowerSyncDatabase instance.
Future<PowerSyncDatabase> initPowerSyncDatabase() async {
  final dbPath = await getDatabasePath();

  final database = PowerSyncDatabase(schema: schema, path: dbPath);
  await database.initialize();

  _setupPowerSyncConnection(database);

  return database;
}

void _setupPowerSyncConnection(PowerSyncDatabase db) {
  final supabase = getIt<SupabaseClient>();

  MyBackendConnector? currentConnector;

  if (supabase.auth.currentSession != null) {
    currentConnector = MyBackendConnector(db);
    db.connect(connector: currentConnector);
  }

  supabase.auth.onAuthStateChange.listen((data) async {
    final AuthChangeEvent event = data.event;
    if (event == AuthChangeEvent.signedIn) {
      currentConnector = MyBackendConnector(db);
      db.connect(connector: currentConnector!);
    } else if (event == AuthChangeEvent.signedOut) {
      currentConnector = null;
      await db.disconnect();
    } else if (event == AuthChangeEvent.tokenRefreshed) {
      currentConnector?.prefetchCredentials();
    }
  });
}

// Future<PowerSyncDatabase> initPowerSyncDatabase() async {
//   // Open the local database
//   final db = PowerSyncDatabase(
//     schema: schema,
//     path: await getDatabasePath(),
//     logger: attachedLogger,
//   );
//   await db.initialize();

//   MyBackendConnector? currentConnector;

//   if (isLoggedIn()) {
//     // If the user is already logged in, connect immediately.
//     // Otherwise, connect once logged in.
//     currentConnector = MyBackendConnector(db);
//     db.connect(connector: currentConnector);
//   }

//   sl<SupabaseClient>().auth.onAuthStateChange.listen((data) async {
//     final AuthChangeEvent event = data.event;
//     if (event == AuthChangeEvent.signedIn) {
//       // Connect to PowerSync when the user is signed in
//       currentConnector = MyBackendConnector(db);
//       db.connect(connector: currentConnector!);
//     } else if (event == AuthChangeEvent.signedOut) {
//       // Implicit sign out - disconnect, but don't delete data
//       currentConnector = null;
//       await db.disconnect();
//     } else if (event == AuthChangeEvent.tokenRefreshed) {
//       // Supabase token refreshed - trigger token refresh for PowerSync.
//       currentConnector?.prefetchCredentials();
//     }
//   });
// }
