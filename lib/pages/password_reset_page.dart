import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lune/components/custom_dialog.dart';
import 'package:lune/components/my_button.dart';
import 'package:lune/components/my_text_field.dart';
import 'package:lune/services/auth/auth.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final _emailTextController = TextEditingController();

  void _sendPasswordResetEmail() async {
    if (_emailTextController.text == '') {
      _displayMessage('missing-email');
    } else {
      showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _emailTextController.text
        );
        if (context.mounted) {
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        }
      } on FirebaseAuthException catch (e) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        _displayMessage(e.code);
      }
    }
  }

  void _displayMessage(String message) {
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
                    'Reset',
                    style: TextStyle(fontSize: 44),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.112,
                    child: const Text(
                      'Password',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  MyTextField(
                    controller: _emailTextController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.018),
                  MyButton(
                    onTap: _sendPasswordResetEmail,
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const AuthPage()),
                          );
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