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
              padding: const EdgeInsets.symmetric(horizontal: 44),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 342,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 32),
                        SizedBox(
                          width: 310,
                          height: 310,
                          child: Image.asset('assets/images/shiroko_sticker.png'),
                        ),
                      ],
                    ),
                    const Text(
                      'Verification sent',
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'A verification link has been sent to your email. Click the link, then proceed to the login page.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 64),
                    MyButton(
                      onTap: () {
                        Navigator.pushNamed(context, '/authPage');
                      },
                      icon: null,
                      text: 'Proceed to the login page',
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Didn\'t receive the email?'),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: resendEmail,
                          child: Text(
                            'Resend email',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 222),
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