import 'package:flutter/material.dart';
import 'package:lune/firebase_options.dart';
import 'package:lune/pages/introduction_page.dart';
import 'package:lune/services/auth/login_or_sign_up.dart';
import 'package:lune/services/auth/sign_up_or_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

Future<bool> isFirstLaunch() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstLaunch = prefs.getBool('firstLaunch') ?? true;
  return isFirstLaunch;
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
    FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  } catch(e) {
    debugPrint("Failed to initialize Firebase: $e");
  }
  bool firstLaunch = await isFirstLaunch();
  runApp(MyApp(firstLaunch: firstLaunch));
}

class MyApp extends StatelessWidget {
  final bool firstLaunch;
  const MyApp({
    super.key,
    required this.firstLaunch
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: firstLaunch ? const IntroductionPage() : const LoginOrSignUp(),
      routes: {
        '/signUpOrLogin' :(context) => const SignUpOrLogin()
      },
    );
  }
}