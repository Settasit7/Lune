import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

final List<PageViewModel> pages = [
  PageViewModel(
    title: 'Welcome to MyApp',
    body: 'This is a simple introduction screen example',
    // image: Image.asset("assets/intro_image1.png"),
    decoration: const PageDecoration(
      pageColor: Colors.red,
    ),
  ),
  PageViewModel(
    title: 'Welcome to MyApp',
    body: 'This is a simple introduction screen example',
    // image: Image.asset("assets/intro_image1.png"),
    decoration: const PageDecoration(
      pageColor: Colors.white,
    ),
  ),
  PageViewModel(
    title: 'Welcome to MyApp',
    body: 'This is a simple introduction screen example',
    // image: Image.asset("assets/intro_image1.png"),
    decoration: const PageDecoration(
      pageColor: Colors.blue,
    ),
  ),
];

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: pages,
      onDone: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('firstLaunch', false);
        if (!context.mounted) return;
        Navigator.pushNamed(context, '/signUpPage');
      },
      onSkip: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('firstLaunch', false);
        if (!context.mounted) return;
        Navigator.pushNamed(context, '/signUpPage');
      },
      showSkipButton: true,
      skip: const Text('Skip'),
      done: const Text('Done'),
      next: const Icon(Icons.arrow_forward),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.white,
        activeColor: Colors.blue,
        activeSize: Size(20.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}