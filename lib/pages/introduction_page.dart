import 'package:flutter/material.dart';
import 'package:lune/intros/page_1.dart';
import 'package:lune/intros/page_2.dart';
import 'package:lune/intros/page_3.dart';
import 'package:lune/pages/login_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
            height: 480,
            child: PageView(
              controller: _controller,
              onPageChanged: (index) {
                if (index == 3) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                }
              },
              children: const [
                Page1(),
                Page2(),
                Page3(),
                SizedBox.shrink(),
              ],
            ),
          ),
          SmoothPageIndicator(
            controller: _controller,
            count: 3,
            effect: JumpingDotEffect(
              activeDotColor: Theme.of(context).colorScheme.primary,
              dotColor: Theme.of(context).colorScheme.tertiary,
            ),
          )
        ],
      ),
    );
  }
}