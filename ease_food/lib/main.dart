import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './pages/home.dart';
import './pages/splash.dart';
import './pages/signup.dart';
import './pages/login.dart';
import './pages/singleFood.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['supabaseUrl'] ?? '',
    anonKey: dotenv.env['supabaseKey'] ?? '',
  );
  print('Supabase URL //////////////////: ${dotenv.env['supabaseUrl']}');
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const Splash(),
      '/home': (context) => HomePage(),
      '/signup': (context) => const Signup(),
      'login': (context) => const Login(),
      '/Singlefood':(context)=>const Singlefood()
      // '/singleResto': (context) => const SingleResto(restoId:,)
    },
  ));
}

final supabase = Supabase.instance.client;






         