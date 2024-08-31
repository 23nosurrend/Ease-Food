import 'package:flutter/material.dart';
import './pages/home.dart';
import './pages/splash.dart';
import './pages/signup.dart';
import './pages/login.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const Splash(),
      '/home': (context) => HomePage(),
      '/signup': (context) => const Signup(),
      'login':(context)=>const Login()
    },
  ));
}

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
