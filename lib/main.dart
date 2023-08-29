import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/models/task_model.dart';
import './pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  //initialize hive local database
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  //open a hive box
  var box = await Hive.openBox('dataBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
          pageTransitionType: PageTransitionType.leftToRight,
          splashTransition: SplashTransition.fadeTransition,
          splashIconSize: 320,
          centered: true,
          duration: 500,
          backgroundColor: Colors.white,
          splash: Image.asset(fit: BoxFit.fill, 'assets/images/pixel8dark.png'),
          nextScreen: const HomePage()),
    );
  }
}
