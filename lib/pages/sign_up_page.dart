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
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.102),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.072),
                  Image.asset(
                    Theme.of(context).colorScheme.primary == const Color(0xffbe93d4) ? 'assets/images/rabbit_icon.png' : 'assets/images/rabbit_icon_dark.png',
                    width: MediaQuery.of(context).size.width * 0.298,
                    height: MediaQuery.of(context).size.height * 0.138,
                  ),
                  const Text(
                    'Sign up',
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.008),
                  MyTextField(
                    controller: confirmPasswordTextController,
                    hintText: 'Confirm password',
                    obscureText: true,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.018),
                  MyButton(
                    onTap: signUp,
                    icon: null,
                    text: 'Sign up',
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.198),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('See ->'),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: _launchUrl,
                        child: Text(
                          'Terms of Service',
                          style: TextStyle(color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ],
                  ),
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