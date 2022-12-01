import 'package:admin/constants.dart';
import 'package:admin/di/injector.dart';
import 'package:admin/navigation/navigator.dart';
import 'package:admin/screens/auth/login_screen.dart';
import 'package:admin/screens/entrance/bloc/splash_bloc.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashBloc(injector())..add(CheckUserStatus()),
      child: BlocConsumer<SplashBloc, SplashState>(builder: (context, state) {
        return Container(
          color: primaryColor,
        );
      }, listener: (context, state) {
        if (state.status == SplashStatus.authorized) {
          context.navigateTo(MainScreen(), removeStack: true);
        }
        if (state.status == SplashStatus.unAuthorized) {
          context.navigateTo(LoginScreen(), removeStack: true);
        }
      }),
    );
  }
}
