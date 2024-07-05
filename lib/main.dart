import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lune/firebase_options.dart';
import 'package:lune/pages/forgot_page.dart';
import 'package:lune/pages/intro_page.dart';
import 'package:lune/pages/sign_up_page.dart';
import 'package:lune/pages/verify_page.dart';
import 'package:lune/services/auth/auth.dart';
import 'package:lune/themes/dark_theme.dart';
import 'package:lune/themes/light_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> isFirstLaunch() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool isFirstLaunch = prefs.getBool('firstLaunch') ?? true;

  return isFirstLaunch;
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
    FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  // ignore: empty_catches
  } catch(e) {}

  final bool firstLaunch = await isFirstLaunch();

  runApp(MyApp(firstLaunch: firstLaunch));
}

class MyApp extends StatelessWidget {
  final bool firstLaunch;

  const MyApp({
    super.key,
    required this.firstLaunch,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: firstLaunch ? const IntroPage() : const AuthPage(),
      routes: {
        '/authPage': (context) => const AuthPage(),
        '/signUpPage': (context) => const SignUpPage(),
        '/verifyPage': (context) => const VerifyPage(),
        '/forgotPage': (context) => const ForgotPage(),
      },
    );
  }
}