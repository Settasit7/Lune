import 'package:flutter/material.dart';
import 'package:lune/pages/login_page.dart';
import 'package:lune/pages/sign_up_page.dart';

class SignUpOrLogin extends StatefulWidget {
  const SignUpOrLogin({super.key});

  @override
  State<SignUpOrLogin> createState() => _SignUpOrLoginState();
}

class _SignUpOrLoginState extends State<SignUpOrLogin> {
  bool showLoginPage = false;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglePages);
    } else {
      return SignUpPage(onTap: togglePages);
    }
  }
}