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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ToDoDataBase db = ToDoDataBase();
  final _dataBox = Hive.box('dataBox');
  @override
  void initState() {
    if (_dataBox.get("TASKLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Arvo'),
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
          pageTransitionType: PageTransitionType.fade,
          splashTransition: SplashTransition.fadeTransition,
          splashIconSize: 240,
          centered: true,
          duration: 500,
          backgroundColor: db.colorSchemes[db.currentColorScheme]['bgColor'] ??
              Colors.purple[200],
          splash: Image.asset(fit: BoxFit.fill, 'assets/images/pixel8dark.png'),
          nextScreen: const HomePage()),
    );
  }
}
