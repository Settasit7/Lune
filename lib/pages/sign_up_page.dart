import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lune/components/custom_dialog.dart';
import 'package:lune/components/my_button.dart';
import 'package:lune/components/my_text_field.dart';
import 'package:lune/pages/email_verification_page.dart';
import 'package:lune/services/auth/auth.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _confirmPasswordTextController = TextEditingController();

  void _signUp() async {
    if (_emailTextController.text == '') {
      _displayMessage('missing-email');
    } else {
      showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
      if (_passwordTextController.text != _confirmPasswordTextController.text) {
        Navigator.pop(context);
        _displayMessage('passwords-don\'t-match');
        return;
      }
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailTextController.text,
          password: _passwordTextController.text,
        );
        await FirebaseAuth.instance.currentUser?.sendEmailVerification();
        if (context.mounted) {
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          Navigator.push(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(builder: (context) => const EmailVerificationPage()),
          );
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

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse('https://thevendorapplication.web.app/terms-of-services.txt');

    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
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
                    'Sign up',
                    style: TextStyle(fontSize: 44),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.036),
                  MyTextField(
                    controller: _emailTextController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.008),
                  MyTextField(
                    controller: _passwordTextController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.008),
                  MyTextField(
                    controller: _confirmPasswordTextController,
                    hintText: 'Confirm password',
                    obscureText: true,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.018),
                  MyButton(
                    onTap: _signUp,
                    icon: null,
                    text: 'Sign up',
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.018),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('By signing up, you agree to our'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: _launchUrl,
                        child: Text(
                          'Terms of Service',
                          style: TextStyle(color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.156),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Have an account?'),
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