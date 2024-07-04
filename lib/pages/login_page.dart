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

  void login() async {
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
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                Icon(
                  Icons.message,
                  color: Theme.of(context).colorScheme.onInverseSurface,
                  size: 128,
                ),
                const SizedBox(height: 32),
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 32),
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
                  onTap: login,
                  text: 'Login',
                ),
                const SizedBox(height: 64),
                const Text(
                  'Or sign in with',
                  style: TextStyle(
                    fontSize: 16,
                  ),
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
                          text: 'Google',
                        ),
                      ),
                    ),
                    if (Platform.isIOS)
                      const SizedBox(width: 16),
                    if (Platform.isIOS)
                      const Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          child: MyButton(
                            onTap: signInWithApple,
                            text: 'Apple',
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 64),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('No account?'),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/signUpPage');
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onInverseSurface,
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