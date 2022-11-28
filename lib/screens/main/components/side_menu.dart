import 'package:admin/constants.dart';
import 'package:admin/screens/dashboard/create/quote_create_screen.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/dashboard/users/users_screen.dart';
import 'package:admin/screens/quotes/quotes_screen.dart';
import 'package:admin/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideMenu extends StatelessWidget {
  Function(Widget) _onSelectMenu;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: primaryLightColor,
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {
              _onSelectMenu.call(DashboardScreen());
            },
          ),
          DrawerListTile(
            title: "Quotes",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {
              _onSelectMenu.call(QuotesScreen());
            },
          ),
          DrawerListTile(
            title: "Users",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {
              _onSelectMenu.call(UsersScreen());
            },
          ),
          DrawerListTile(
            title: "Create",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {
              _onSelectMenu.call(QuoteCreateScreen());
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
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white,
        height: 16,
      ),
      title: Text(
        title,
        style: getTextStyle(),
      ),
    );
  }
}
