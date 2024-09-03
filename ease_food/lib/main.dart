import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './pages/home.dart';
import './pages/splash.dart';
import './pages/signup.dart';
import './pages/login.dart';




Future<void> main() async {
   await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['supabaseUrl']!,
    anonKey: dotenv.env['supabaseKey']!,
  );
  runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      '/': (context) => const Splash(),
      '/home': (context) => HomePage(),
      '/signup': (context) => const Signup(),
      'login': (context) => const Login()
    },
  ));
}
final supabase = Supabase.instance.client;




// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(fontFamily: 'Schyler'),
//       initialRoute: '/':const (context),
//       home: HomePage(),
//     );
//   }
// }
