import 'package:flutter/material.dart';
import 'package:lune/components/my_button.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({super.key});

  @override
  State<ForgotPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<ForgotPage> {

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