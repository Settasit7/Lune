import 'package:flutter/material.dart';
import 'package:lune/intros/page_1.dart';
import 'package:lune/intros/page_2.dart';
import 'package:lune/intros/page_3.dart';

class IntroductionPage extends StatelessWidget {
  IntroductionPage({super.key});
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 500,
            child: PageView(
              controller: _controller,
              children: const [
                Page1(),
                Page2(),
                Page3(),
              ],
            ),
          )
        ],
      ),
    );
  }
}