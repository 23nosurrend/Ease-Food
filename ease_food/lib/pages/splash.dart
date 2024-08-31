import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/signup');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color:Colors.white,
      child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/pizza.jpg',width:100,height:100),
              const Text('Ease Food',
              style:TextStyle(
                color:Colors.brown,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none
              )
              
              )
            ],
          )),
    );
  }
}
