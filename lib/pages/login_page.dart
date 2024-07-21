import 'dart:io' show Platform;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lune/components/custom_dialog.dart';
import 'package:lune/components/my_button.dart';
import 'package:lune/components/my_text_field.dart';
import 'package:lune/pages/password_reset_page.dart';
import 'package:lune/pages/sign_up_page.dart';
import 'package:lune/services/auth/auth.dart';
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
    if (emailTextController.text == '') {
      displayMessage('missing-email');
    } else {
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
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          if (FirebaseAuth.instance.currentUser!.emailVerified) {
            Navigator.push(
              // ignore: use_build_context_synchronously
              context,
              MaterialPageRoute(
                builder: (context) => const AuthPage()
              )
            );
          } else {
            displayMessage('email-not-verified');
          }
        }
      } on FirebaseAuthException catch (e) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        if (e.code == 'wrong-password') {
          displayMessage('invalid-password');
        } else {
          displayMessage(e.code);
        }
      }
    }
  }

  void displayMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => CustomDialog(message: message),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.102),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.072),
                  Hero(
                    tag: 'icon',
                    child: Image.asset(
                      Theme.of(context).colorScheme.primary == const Color(0xffbe93d4) ? 'assets/images/rabbit_icon.png' : 'assets/images/rabbit_icon_dark.png',
                      width: MediaQuery.of(context).size.width * 0.298,
                      height: MediaQuery.of(context).size.height * 0.138,
                    ),
                  ),
                  const Text(
                    'R@bbit',
                    style: TextStyle(fontSize: 44),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.036),
                  MyTextField(
                    controller: emailTextController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.008),
                  MyTextField(
                    controller: passwordTextController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.018),
                  MyButton(
                    onTap: logIn,
                    icon: null,
                    text: 'Log in',
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.018),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PasswordResetPage(),
                            )
                          );
                        },
                        child: Text(
                          'Forgot password',
                          style: TextStyle(color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.060),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Divider(color: Theme.of(context).colorScheme.onSurface),
                      ),
                      const SizedBox(width: 16),
                      const Text("or sign in with"),      
                      const SizedBox(width: 16),  
                      Expanded(
                        child: Divider(color: Theme.of(context).colorScheme.onSurface),
                      ),
                    ]
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.036),
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.068),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account?'),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpPage()
                            )
                          );
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.018),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}