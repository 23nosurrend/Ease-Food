import 'package:powersync/powersync.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import './modals//schema.dart';

late final PowerSyncDatabase db;

Future<String> getDatabasePath() async {
  final dir = await getApplicationSupportDirectory();
  return join(dir.path, 'powersync-demo.db');
}

bool isLogged() {
  return Supabase.instance.client.auth.currentSession?.accessToken != null;
}

Future<void> openDatabase() async {
  try {
   
    db = PowerSyncDatabase(schema: schema, path: await getDatabasePath());
    await db.initialize();
    await dotenv.load(fileName: ".env");
    await Supabase.initialize(
      url: dotenv.env['supabaseUrl'] ?? '',
      anonKey: dotenv.env['supabaseKey'] ?? '',
    );
    SupabaseConnector? currentConnector;
    if (isLogged()) {
      currentConnector = SupabaseConnector(db);
      db.connect(connector: currentConnector);
    }
    Supabase.instance.client.auth.onAuthStateChange.listen((Data) async {
      final AuthChangeEvent event = Data.event;
      // use can signIn, signout
      if (event == AuthChangeEvent.signedIn) {
        currentConnector = SupabaseConnector(db);
        db.connect(connector: currentConnector!);
      } else if (event == AuthChangeEvent.signedOut) {
        currentConnector = null;
        await db.disconnect();
      } else if (event == AuthChangeEvent.tokenRefreshed) {
        currentConnector?.prefetchCredentials();
      }
    });
  } catch (error) {
    print('error from openDatabase is : $error');
  }
}

class SupabaseConnector extends PowerSyncBackendConnector {
  PowerSyncDatabase db;
  SupabaseConnector(this.db);
  @override
  Future<void> uploadData(PowerSyncDatabase database) {
    throw UnimplementedError();
  }

  @override
  Future<PowerSyncCredentials?> fetchCredentials() async {
    final session = Supabase.instance.client.auth.currentSession;
    if (session == null) {
      print('No Supabase session found, returning null');
      return null;
    }
    final token = session.accessToken;
    return PowerSyncCredentials(
        endpoint: 'https://66f27f017337c371e06a32e6.powersync.journeyapps.com',
        token: token);
  }
}
