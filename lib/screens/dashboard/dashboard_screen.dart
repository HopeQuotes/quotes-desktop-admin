import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/basic_info_widgets.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/header.dart';

import 'components/popular_quotes_widget.dart';
import 'components/quote_info_widget.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                        SizedBox(height: defaultPadding),
                        RecentFiles(),
                        if (Responsive.isMobile(context))
                          SizedBox(height: defaultPadding),
                        if (Responsive.isMobile(context)) QuoteDetails(),
                      ],
                    ),
                  ),
                  SizedBox(width: 250),
                  if (!Responsive.isMobile(context))
                    SizedBox(width: defaultPadding),
                  // On Mobile means if the screen is less than 850 we dont want to show it
                  // if (!Responsive.isMobile(context))
                  //   Expanded(
                  //     flex: 2,
                  //     child: QuoteDetails(),
                  //   ),
                ],
              )
            ],
          ),
        ),
      ),
      backgroundColor: primaryColor,
    );
  }
}
