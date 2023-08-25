import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import './theme/theme_constants.dart';
import './pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themes[0],
      home: AnimatedSplashScreen(
          pageTransitionType: PageTransitionType.leftToRight,
          splashTransition: SplashTransition.fadeTransition,
          splashIconSize: 320,
          centered: true,
          duration: 4500,
          backgroundColor: const Color(0xFFCE93D8),
          splash: Image.asset(fit: BoxFit.fill, 'assets/images/splash.gif'),
          nextScreen: const HomePage()),
    );
  }
}
