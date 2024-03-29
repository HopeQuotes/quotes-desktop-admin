import 'package:admin/constants.dart';
import 'package:admin/screens/quotes/quote_states_tab.dart';
import 'package:admin/screens/quotes/widgets/quote_item_widget.dart';
import 'package:admin/utils/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/injector.dart';
import 'bloc/quotes_bloc.dart';

class QuotesScreen extends StatefulWidget {
  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuotesBloc(injector())
        ..add(GetQuoteStates())
        ..add(LoadQuotes()),
      child: BlocConsumer<QuotesBloc, QuotesState>(
        builder: (context, state) {
          final bloc = context.read<QuotesBloc>();

          return Scaffold(
            backgroundColor: primaryColor,
            appBar: PreferredSize(
              preferredSize: Size(double.infinity, 72),
              child: Container(
                height: 72,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 24),
                      child: Text(
                        "Quotes list",
                        style: getTextStyle(color: Colors.white, size: 20),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(24),
                    ),
                    if (state.quoteStates != null)
                      Flexible(
                        flex: 1,
                        child: QuoteStatesTab(
                          states: state.quoteStates!,
                          onSelectState: (state) {
                            //
                          },
                        ),
                      ),
                    Spacer(),
                  ],
                ),
              ),
            ),
            body: (state.quotesPagingStatus != QuotesPagingStatus.success)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : (state.quotes?.isNotEmpty == true &&
                        state.quoteStates?.isNotEmpty == true)
                    ? GridView.builder(
                        padding: EdgeInsets.all(12),
                        shrinkWrap: true,
                        itemCount: state.quotes?.length,
                        controller: bloc.hashtagScrollController,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 1.1,
                          crossAxisSpacing: defaultPadding,
                          mainAxisSpacing: defaultPadding,
                        ),
                        itemBuilder: (context, index) => QuoteItemWidget(
                          quote: state.quotes![index],
                          states: state.quoteStates ?? [],
                          onQuoteStateUpdated: (quote, newState) {
                            bloc.add(SetQuoteState(
                                stateId: newState.id, quoteId: quote.id));
                          },
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
          );
        },
        listener: (context, state) {
          //
        },
      ),
    );
  }
}
