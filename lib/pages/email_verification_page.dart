// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lune/components/custom_dialog.dart';
import 'package:lune/components/my_button.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {

  void resendEmail() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
      if (context.mounted) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayMessage(e.code);
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
                  const Text(
                    '',
                    style: TextStyle(fontSize: 44),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.662,
                    height: MediaQuery.of(context).size.height * 0.306,
                    child: Image.asset('assets/images/shiroko_sticker.png'),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.084,
                    child: const Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'Verification sent',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.094,
                    child: const Text('Please see the verification email'),
                  ),
                  MyButton(
                    onTap: () {
                      Navigator.pushNamed(context, '/authPage');
                    },
                    icon: null,
                    text: 'Proceed to the login page',
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.018),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Didn\'t receive the email?'),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: resendEmail,
                        child: Text(
                          'Resend',
                          style: TextStyle(color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ],
                  ),
                  const Text(''),
                  const Text(''),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.174),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}