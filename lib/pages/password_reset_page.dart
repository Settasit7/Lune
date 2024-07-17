// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lune/components/custom_dialog.dart';
import 'package:lune/components/my_button.dart';
import 'package:lune/components/my_text_field.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final emailTextController = TextEditingController();

  void sendPasswordResetEmail() async {
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
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailTextController.text
        );
        if (context.mounted) {
          Navigator.pop(context);
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
                    'Reset',
                    style: TextStyle(fontSize: 44),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.068,
                    child: const Text(
                      'Password',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.044),
                  MyTextField(
                    controller: emailTextController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.018),
                  MyButton(
                    onTap: sendPasswordResetEmail,
                    icon: null,
                    text: 'Send',
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.018),
                  const Text(''),
                  const Text(''),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.232),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Reset password already?'),
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