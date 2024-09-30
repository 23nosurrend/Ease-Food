import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './pages/home.dart';
import './pages/splash.dart';
import './pages/signup.dart';
import './pages/login.dart';
import './pages/singleFood.dart';
import './pages/order.dart';
import './pages/PaymentScreen.dart';
import './powersync.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await openDatabase();
  // await dotenv.load(fileName: ".env");
  // await Supabase.initialize(
  //   url: dotenv.env['supabaseUrl'] ?? '',
  //   anonKey: dotenv.env['supabaseKey'] ?? '',
  // );
  final results = await db.getAll('SELECT * from restos');
  print('results:$results');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Supabase App',
      initialRoute: '/payment',
      routes: {
        '/kkk': (context) => const Splash(),
        '/home': (context) => HomePage(),
        '/signup': (context) => const Signup(),
        '/login': (context) => const Login(),
        '/order': (context) => const Orders(),
        '/payment':(context)=>const Payment()
        // '/Singlefood':(context) => const Singlefood()
      },
    );
  }
}
