import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lune/pages/home_page.dart';
import 'package:lune/services/auth/sign_up_or_login.dart';

class NewAuthPage extends StatelessWidget {
  const NewAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const SignUpOrLogin();
          }
        },
      ),
    );
  }
}