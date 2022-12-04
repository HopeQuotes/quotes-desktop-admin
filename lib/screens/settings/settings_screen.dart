import 'package:admin/common_widgets/button_widget.dart';
import 'package:admin/constants.dart';
import 'package:admin/navigation/navigator.dart';
import 'package:admin/screens/entrance/splash_screen.dart';
import 'package:admin/screens/settings/bloc/settings_bloc.dart';
import 'package:admin/screens/settings/bloc/settings_event.dart';
import 'package:admin/screens/settings/bloc/settings_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: BlocProvider(
        create: (_) => SettingsBloc(),
        child: BlocConsumer<SettingsBloc, SettingsState>(
            builder: (context, state) {
          return Container(
            child: Button(
              width: 100,
              height: 52,
              title: 'Logout',
              onClick: () {
                context.read<SettingsBloc>().add(LogOut());
                context.navigateTo(SplashScreen());
              },
            ),
          );
        }, listener: (context, state) {
          //
        }),
      ),
    );
  }
}
