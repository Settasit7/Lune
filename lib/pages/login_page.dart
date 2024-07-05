// ignore_for_file: use_build_context_synchronously

import 'dart:io' show Platform;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lune/components/my_button.dart';
import 'package:lune/components/my_text_field.dart';
import 'package:lune/services/auth/sign_in_with_apple.dart';
import 'package:lune/services/auth/sign_in_with_google.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  void logIn() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );
      if (context.mounted) {
        Navigator.pop(context);
        if (FirebaseAuth.instance.currentUser!.emailVerified) {
          Navigator.pushNamed(context, '/authPage');
        } else {
          displayMessage("Go verify");
        }
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayMessage(e.code);
    }
  }

  void displayMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 44),
            child: Column(
              children: [
                const SizedBox(height: 64),
                Image.asset('assets/images/coffee_cup.png'),
                const SizedBox(height: 16),
                const Text(
                  'Lune',
                  style: TextStyle(
                    fontSize: 44,
                  ),
                ),
                const SizedBox(height: 24),
                MyTextField(
                  controller: emailTextController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 8),
                MyTextField(
                  controller: passwordTextController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                MyButton(
                  onTap: logIn,
                  icon: null,
                  text: 'Log in',
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/forgotPage');
                      },
                      child: Text(
                        'Forgot password',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                  ],
                ),
                const SizedBox(height: 68),
                Row(
                  children: <Widget>[
                      Expanded(
                          child: Divider(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                      ),
                      const SizedBox(width: 8),
                      const Text("or sign in with"),      
                      const SizedBox(width: 8),  
                      Expanded(
                          child: Divider(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                      ),
                  ]
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        child: MyButton(
                          onTap: signInWithGoogle,
                          icon: 'assets/images/google_icon.png',
                          text: 'Google',
                        ),
                      ),
                    ),
                    if (Platform.isIOS) ...[
                      const SizedBox(width: 16),
                      const Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          child: MyButton(
                            onTap: signInWithApple,
                            icon: 'assets/images/apple_icon.png',
                            text: 'Apple',
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
                const SizedBox(height: 56),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?'),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/signUpPage');
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}