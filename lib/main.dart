import 'package:admin/controllers/MenuController.dart';
import 'package:admin/di/injector.dart';
import 'package:admin/screens/auth/login_screen.dart';
import 'package:admin/screens/entrance/splash_screen.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:temu_interceptor/navigation/navigator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      title: 'Quote admin',
      debugShowCheckedModeBanner: false,
      home: Material(
        child: SplashScreen(),
      ),
    );
  }
}
