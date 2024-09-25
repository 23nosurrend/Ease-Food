import 'package:flutter/material.dart';
import './login.dart';
import '../main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
   bool _isObscure = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Future<void> signup() async {
    try {
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(content: Text('Please Enter all inputs'));
            });
        return;
      }
      final supabase = Supabase.instance.client;
      final AuthResponse res = await supabase.auth.signUp(
        email: emailController.text,
        password: passwordController.text,
      );
      final Session? session = res.session;
      final User? user = res.user;

      if (user != null) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(content: Text('user created succesfully'));
            });
      }
    } catch (error) {
      showDialog(
          context: context,
          builder: (content) {
            return AlertDialog(content: Text('Error: ${error.toString()}'));
          });
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign Up your meal ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Await you! ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      },
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                            color: Color(0xffD42323),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                SizedBox(
                  width: 350,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Email'),
                  ),
                ),
                const SizedBox(height: 60),
                SizedBox(
  width: 350,
  child: TextField(
    controller: passwordController,
    obscureText: _isObscure, // Controls if the password is shown or hidden
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      labelText: 'Password',
      suffixIcon: IconButton(
        icon: Icon(
          _isObscure ? Icons.visibility : Icons.visibility_off, // Toggles the eye icon
        ),
        onPressed: () {
          setState(() {
            _isObscure = !_isObscure; // Switches between hiding and showing the password
          });
        },
      ),
    ),
  ),
),
                const SizedBox(height: 60),
                SizedBox(
                    width: 350,
                    child: SizedBox(
                      height: 70,
                      child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                                const Color(0xff633631)),
                          ),
                          onPressed: () {
                            signup();
                          },
                          child: const Text("Sign Up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18))),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}


