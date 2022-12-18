import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/models/ui/quote.dart';
import '../../utils/color.dart';
import '../../utils/fonts.dart';

class QuoteStatesTab extends StatefulWidget {
  final List<QuoteState> states;
  final Function(QuoteState) onSelectState;

  @override
  State<QuoteStatesTab> createState() => _QuoteStatesTabState();

  const QuoteStatesTab({
    required this.states,
    required this.onSelectState,
  });
}

class _QuoteStatesTabState extends State<QuoteStatesTab>
    with TickerProviderStateMixin {
  late TabController tabController;
  var stateIndex = 0;

  @override
  void initState() {
    tabController = TabController(length: widget.states.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: TabBar(
        controller: tabController,
        onTap: (index) {
          setState(() {
            stateIndex = index;
          });
          widget.onSelectState.call(widget.states[index]);
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
    );
  }
}
