// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lune/components/custom_dialog.dart';
import 'package:lune/components/my_button.dart';
import 'package:lune/services/auth/auth.dart';

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
                    'Email',
                    style: TextStyle(fontSize: 44),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.198,
                    child: const Text(
                      'Verification',
                      style: TextStyle(fontSize: 19),
                    ),
                  ),
                  MyButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AuthPage(),
                        )
                      );
                    },
                    icon: null,
                    text: 'Yes, I\'ve clicked the link',
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.018),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Didn\'t receive the link?'),
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.250),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}