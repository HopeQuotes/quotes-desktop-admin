import 'package:admin/di/injector.dart';
import 'package:admin/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';
import '../components/basic_info_widgets.dart';
import '../components/header.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardBloc(injector())..add(GetProfile()),
      child: BlocConsumer<DashboardBloc, DashboardState>(
          builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(defaultPadding),
              child: Column(
                children: [
                  Header(),
                  SizedBox(height: defaultPadding),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            BasicInfoWidgets(),
                          ],
                        ),
                      ),
                      SizedBox(width: 250),
                    ],
                  )
                ],
              ),
            ),
          ),
          backgroundColor: primaryColor,
        );
      }, listener: (context, state) {
        //
      }),
    );
  }
}
