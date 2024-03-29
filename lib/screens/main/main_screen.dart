import 'package:admin/controllers/MenuController.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'components/side_menu.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _currentScreen = DashboardScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(
        onSelectMenu: (screen) {
          _setCurrentScreen(screen);
        },
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(
                  onSelectMenu: (screen) {
                    _setCurrentScreen(screen);
                  },
                ),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: _currentScreen,
            ),
          ],
        ),
      ),
    );
  }

  _setCurrentScreen(Widget widget) {
    setState(() {
      _currentScreen = widget;
    });
  }
}
