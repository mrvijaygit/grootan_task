import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grootan_task/screens/home_page.dart';
import 'package:grootan_task/screens/login_data_view_page.dart';
import 'package:grootan_task/screens/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final routes = {
    '/login': (BuildContext context) =>  const LoginPage(),
    '/home': (BuildContext context) => const HomeScreen(),
    '/loginData': (BuildContext context) => const LoginDataViewPage(),
    '/': (BuildContext context) =>  const LoginPage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
      debugShowCheckedModeBanner: false,
      title: 'Task',
      theme: ThemeData(
        textTheme:
        const TextTheme(
          subtitle1: TextStyle(color: Colors.white), //<-- SEE HERE
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}