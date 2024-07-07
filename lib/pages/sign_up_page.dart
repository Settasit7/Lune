// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lune/components/custom_dialog.dart';
import 'package:lune/components/my_button.dart';
import 'package:lune/components/my_text_field.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> _launchUrl() async {
  final Uri url = Uri.parse('https://thevendorapplication.web.app/terms-of-services.txt');

  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  void signUp() async {
    if (emailTextController.text == '') {
      displayMessage('missing-email');
    } else {
      showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
      if (passwordTextController.text != confirmPasswordTextController.text) {
        Navigator.pop(context);
        displayMessage('passwords-don\'t-match');
        return;
      }
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text,
        );
        await FirebaseAuth.instance.currentUser?.sendEmailVerification();
        if (context.mounted) {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/emailVerificationPage');
        }
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        displayMessage(e.code);
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
              padding: const EdgeInsets.symmetric(horizontal: 44),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 342,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 68),
                    Image.asset('assets/images/coffee_cup.png'),
                    const Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 44,
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
                    const SizedBox(height: 8),
                    MyTextField(
                      controller: confirmPasswordTextController,
                      hintText: 'Confirm password',
                      obscureText: true,
                    ),
                    const SizedBox(height: 16),
                    MyButton(
                      onTap: signUp,
                      icon: null,
                      text: 'Sign up',
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('By signing up, you agree to'),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: _launchUrl,
                          child: Text(
                            'Terms of Services',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 170),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Have an account?'),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/authPage');
                          },
                          child: Text(
                            'Log in',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}