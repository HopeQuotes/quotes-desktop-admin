import 'package:admin/utils/array.dart';
import 'package:admin/utils/color.dart';
import 'package:admin/utils/fonts.dart';
import 'package:flutter/material.dart';

import '../../../../domain/models/ui/quote.dart';

class QuoteItemWidget extends StatefulWidget {
  final Quote quote;
  final List<QuoteState> states;
  final Function(Quote, QuoteState) onQuoteStateUpdated;

  @override
  State<QuoteItemWidget> createState() => _QuoteItemWidgetState();

  const QuoteItemWidget({
    required this.quote,
    required this.states,
    required this.onQuoteStateUpdated,
  });
}

class _QuoteItemWidgetState extends State<QuoteItemWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;

  var stateIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    stateIndex = widget.states
        .indexWhere((element) => element.id == widget.quote.state.id);
    _tabController.animateTo(stateIndex);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListTile(
            title: Container(
              child: Text(
                widget.quote.author,
                style:
                    getTextStyle(color: Colors.white.withAlpha(200), size: 16),
              ),
              margin: EdgeInsets.all(12),
            ),
            subtitle: Container(
              child: Text(
                widget.quote.text.ellipsize(200),
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
                widget.onQuoteStateUpdated
                    .call(widget.quote, widget.states[stateIndex]);
              },
              labelStyle: getTextStyle(size: 12),
              splashBorderRadius: BorderRadius.circular(16),
              unselectedLabelColor: Colors.white.withAlpha(52),
              indicator: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: HexColor.fromHex(widget.states[stateIndex].color)),
              isScrollable: false,
              tabs: widget.states
                  .map(
                    (e) => Tab(
                      height: 32,
                      text: e.value,
                    ),
                  )
                  .toList(),
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
