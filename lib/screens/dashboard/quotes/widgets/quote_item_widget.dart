import 'package:admin/utils/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../domain/models/ui/quote.dart';

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
  var stateIndex = -1;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    if (widget._quote.state == "pending") {
      stateIndex = 1;
    }

    if (widget._quote.state == "verified") {
      stateIndex = 0;
    }

    if (widget._quote.state == "rejected") {
      stateIndex = 2;
    }
    _tabController.animateTo(stateIndex);

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
    return Container(
      child: Column(
        children: [
          ListTile(
            title: Container(
              child: Text(
                widget._quote.author,
                style:
                    getTextStyle(color: Colors.white.withAlpha(200), size: 16),
              ),
              margin: EdgeInsets.all(12),
            ),
            subtitle: Container(
              child: Text(
                widget._quote.text,
                style:
                    getTextStyle(color: Colors.white.withAlpha(200), size: 14),
              ),
              margin: EdgeInsets.all(12),
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
            child: TabBar(
              controller: _tabController,
              onTap: (index) {
                setState(() {
                  stateIndex = index;
                });
              },
              labelStyle: getTextStyle(size: 12),
              splashBorderRadius: BorderRadius.circular(16),
              unselectedLabelColor: Colors.white.withAlpha(52),
              indicator: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: _getColorByState()),
              isScrollable: false,
              tabs: [
                Tab(
                  height: 32,
                  text: 'verified',
                ),
                Tab(
                  height: 32,
                  text: 'pending',
                ),
                Tab(
                  height: 32,
                  text: 'rejected',
                ),
              ],
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(12),
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
