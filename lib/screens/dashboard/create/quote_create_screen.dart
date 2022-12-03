import 'package:admin/common_widgets/button_widget.dart';
import 'package:admin/constants.dart';
import 'package:admin/di/injector.dart';
import 'package:admin/screens/dashboard/create/bloc/create_quote_bloc.dart';
import 'package:admin/screens/hashtag/hashtag_list_widget.dart';
import 'package:admin/utils/array.dart';
import 'package:admin/utils/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common_widgets/chip_item_widget.dart';
import '../../../common_widgets/input_widget.dart';

class QuoteCreateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor,
      body: BlocProvider(
        create: (_) => CreateQuoteBloc(injector()),
        child: BlocConsumer<CreateQuoteBloc, CreateQuoteState>(
          builder: (context, state) {
            var bloc = context.read<CreateQuoteBloc>();
            return SingleChildScrollView(
              child: Row(
                children: [
                  Flexible(
                    flex: 4,
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
                            margin: const EdgeInsets.only(
                                left: 24, right: 24, top: 24),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: size.width / 2,
                          child: Input(
                            multiLine: true,
                            hint: 'Body...',
                            margin: const EdgeInsets.only(
                                left: 24, right: 24, top: 24),
                          ),
                        ),
                        Container(
                            alignment: Alignment.topLeft,
                            width: size.width / 2,
                            margin: const EdgeInsets.all(16),
                            child: RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                children: [
                                  ...(state.hashtags).mapIndexed(
                                    (index, e) => WidgetSpan(
                                      child: ChipItem(
                                        text: e.value,
                                        onDelete: (index) {
                                          bloc.add(RemoteHashTag(hashtag: e));
                                        },
                                        index: index,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
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
                  Flexible(
                    flex: 2,
                    child: HashtagListWidget(
                      onSelectHashTag: (hashtag) {
                        print("VALUE ${hashtag.value}");
                        bloc.add(AddHashTag(hashtag: hashtag));
                      },
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
