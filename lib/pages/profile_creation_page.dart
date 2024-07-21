import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lune/components/my_button.dart';
import 'package:lune/services/auth/auth.dart';

class ProfileCreationPage extends StatelessWidget {
  const ProfileCreationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: MyButton(
        onTap: () {
          FirebaseAuth.instance.signOut();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AuthPage(),
            )
          );
        },
        icon: null,
        text: 'Log out',
      ),
    );
  }
}