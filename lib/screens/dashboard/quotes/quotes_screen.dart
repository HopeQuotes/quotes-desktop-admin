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
      body: BlocProvider(
        create: (_) => QuotesBloc(injector()),
        child: BlocConsumer<QuotesBloc, QuotesState>(
          builder: (context, state) {
            if (state.quotes?.isEmpty == true) {
              return Container(
                child: Text(
                  'Nothing found...',
                  style: getTextStyle(),
                ),
              );
            }
            return ListView.builder(itemBuilder: (e, i) {
              return QuoteItemWidget(quote: state.quotes![i]);
            });
          },
          listener: (context, state) {
            //
          },
        ),
      ),
    );
  }
}
