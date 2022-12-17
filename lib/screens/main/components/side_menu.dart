import 'package:admin/constants.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/hashtag/hashtag_screen.dart';
import 'package:admin/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../create_quote/quote_create_screen.dart';
import '../../quotes/quotes_screen.dart';
import '../../settings/settings_screen.dart';
import '../../users/users_screen.dart';

class SideMenu extends StatelessWidget {
  final Function(Widget) _onSelectMenu;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: primaryLightColor,
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Text(
                "Quotes admin",
                style: getTextStyle(size: 20),
              ),
            ),
          ),
          DrawerListTile(
            title: "Dashboard",
            icon: Icons.dashboard,
            press: () {
              _onSelectMenu.call(DashboardScreen());
            },
          ),
          DrawerListTile(
            title: "Quotes",
            icon: Icons.menu_book_sharp,
            press: () {
              _onSelectMenu.call(QuotesScreen());
            },
          ),
          DrawerListTile(
            title: "Users",
            icon: Icons.supervised_user_circle,
            press: () {
              _onSelectMenu.call(UsersScreen());
            },
          ),
          DrawerListTile(
            title: "Create",
            icon: Icons.add,
            press: () {
              _onSelectMenu.call(QuoteCreateScreen());
            },
          ),
          DrawerListTile(
            title: "Hashtag",
            icon: Icons.tag,
            press: () {
              _onSelectMenu.call(HashtagScreen());
            },
          ),
          DrawerListTile(
            title: "Settings",
            icon: Icons.settings,
            press: () {
              _onSelectMenu.call(SettingsScreen());
            },
          ),
        ],
      ),
    );
  }

  SideMenu({
    required Function(Widget) onSelectMenu,
  }) : _onSelectMenu = onSelectMenu;
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: getTextStyle(),
      ),
    );
  }
}
