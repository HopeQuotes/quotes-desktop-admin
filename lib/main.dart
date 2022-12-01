import 'package:admin/controllers/MenuController.dart';
import 'package:admin/di/injector.dart';
import 'package:admin/screens/auth/login_screen.dart';
import 'package:admin/screens/entrance/splash_screen.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
  initDependencies();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quote admin',
      debugShowCheckedModeBanner: false,
      home: Material(
        child: SplashScreen(),
      ),
    );
  }
}
