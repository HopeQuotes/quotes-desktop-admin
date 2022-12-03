import 'package:admin/constants.dart';
import 'package:admin/models/quote.dart';
import 'package:admin/screens/dashboard/quotes/bloc/quotes_bloc.dart';
import 'package:admin/screens/dashboard/quotes/widgets/quote_item_widget.dart';
import 'package:admin/utils/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/injector.dart';

class QuotesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: BlocProvider(
        create: (_) => QuotesBloc(injector()),
        child: BlocConsumer<QuotesBloc, QuotesState>(
          builder: (context, state) {
            final bloc = context.read<QuotesBloc>();
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(24),
                        child: Text(
                          'Quotes',
                          style: getTextStyle(size: 24),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  GridView.builder(
                    padding: EdgeInsets.all(12),
                    shrinkWrap: true,
                    itemCount: 10,
                    controller: bloc.hashtagScrollController,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.1,
                      crossAxisSpacing: defaultPadding,
                      mainAxisSpacing: defaultPadding,
                    ),
                    itemBuilder: (context, index) => QuoteItemWidget(
                      quote: Quote(),
                    ),
                  ),
                ],
              ),
            );
          },
          listener: (context, state) {
            //
          },
        ),
      ),
    );
  }
}
