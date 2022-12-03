import 'package:admin/models/quote.dart';
import 'package:admin/utils/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';

class QuoteItemWidget extends StatefulWidget {
  final Quote _quote;

  @override
  State<QuoteItemWidget> createState() => _QuoteItemWidgetState();

  const QuoteItemWidget({
    required Quote quote,
  }) : _quote = quote;
}

class _QuoteItemWidgetState extends State<QuoteItemWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;
  var stateIndex = 1;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.animateTo(1);
    super.initState();
  }

  Color _getColorByState() {
    if (stateIndex == 0) {
      return Colors.green;
    }
    if (stateIndex == 1) {
      return Colors.white.withAlpha(100);
    }
    return primaryRedColor;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(12),
          child: ListTile(
            title: Container(
              child: Text(
                widget._quote.title ?? "Temur",
                style: getTextStyle(color: Colors.white.withAlpha(200)),
              ),
              margin: EdgeInsets.all(12),
            ),
            subtitle: Container(
              child: Text(
                widget._quote.body ??
                    "I got this to work with the latest build_runner and json_serializable versions after a long processI got this to work with the latest build_runner and json_serializable versions after a long processI got this to work with the latest build_runner and json_serializable versions after a long processvvv",
                style: getTextStyle(color: Colors.white.withAlpha(200)),
              ),
              margin: EdgeInsets.all(12),
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(12),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        Container(
          margin: EdgeInsets.all(12),
          child: TabBar(
            controller: _tabController,
            onTap: (index) {
              setState(() {
                stateIndex = index;
              });
            },
            labelStyle: getTextStyle(),
            splashBorderRadius: BorderRadius.circular(24),
            unselectedLabelColor: Colors.white.withAlpha(52),
            indicator: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                color: _getColorByState()),
            isScrollable: false,
            tabs: [
              Tab(
                height: 42,
                text: 'verified',
              ),
              Tab(
                height: 42,
                text: 'pending',
              ),
              Tab(
                height: 42,
                text: 'rejected',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
