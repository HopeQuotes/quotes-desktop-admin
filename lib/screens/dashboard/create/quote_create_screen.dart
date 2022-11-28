import 'package:admin/common_widgets/button_widget.dart';
import 'package:admin/constants.dart';
import 'package:admin/utils/array.dart';
import 'package:admin/utils/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common_widgets/add_chip_item_widget.dart';
import '../../../common_widgets/chip_item_widget.dart';
import '../../../common_widgets/input_widget.dart';

class QuoteCreateScreen extends StatefulWidget {
  @override
  State<QuoteCreateScreen> createState() => _QuoteCreateScreenState();
}

class _QuoteCreateScreenState extends State<QuoteCreateScreen> {
  List<String> hashTags = ["quote", "happiness", "family", "hi"];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  child: Text(
                    "Create quote",
                    style: getTextStyle(size: 24),
                  ),
                  margin: EdgeInsets.all(24),
                ),
                Spacer(),
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: size.width / 2,
              child: Input(
                hint: 'Author',
                margin: const EdgeInsets.only(left: 24, right: 24, top: 24),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: size.width / 2,
              child: Input(
                multiLine: true,
                hint: 'Body...',
                margin: const EdgeInsets.only(left: 24, right: 24, top: 24),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              width: size.width / 2,
              margin: const EdgeInsets.all(16),
              child: Flexible(
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      ...hashTags.mapIndexed(
                        (index, e) => WidgetSpan(
                          child: ChipItem(
                            text: e,
                            onDelete: (index) {
                              setState(() {
                                hashTags.removeAt(index);
                              });
                            },
                            index: index,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ChipItemAdd(onClick: (tag) {
              setState(() {
                hashTags.add(tag);
              });
            }),
            Container(
              padding: EdgeInsets.all(24),
              alignment: Alignment.centerRight,
              child: Button(
                width: 152,
                height: 56,
                disabled: false,
                title: 'Create',
                onClick: () {
                  //
                },
              ),
              width: size.width / 2,
            )
          ],
        ),
      ),
    );
  }
}
