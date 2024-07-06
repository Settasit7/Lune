import 'package:flutter/material.dart';
import 'package:lune/components/my_button.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                // MyButton(
                //   onTap: () {
                //     Navigator.pushNamed(context, '/authPage');
                //   },
                //   text: 'I verified my email',
                // ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}