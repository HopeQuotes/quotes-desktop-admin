import 'package:admin/common_widgets/button_widget.dart';
import 'package:admin/constants.dart';
import 'package:admin/di/injector.dart';
import 'package:admin/screens/dashboard/create_quote/bloc/create_quote_bloc.dart';
import 'package:admin/screens/hashtag/hashtag_list_widget.dart';
import 'package:admin/utils/array.dart';
import 'package:admin/utils/fonts.dart';
import 'package:admin/utils/print.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common_widgets/chip_item_widget.dart';
import '../../../common_widgets/input_widget.dart';
import 'hashtags_list_widget.dart';

class QuoteCreateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor,
      body: BlocProvider(
        create: (_) => CreateQuoteBloc(injector())..add(LoadHashTags()),
        child: BlocConsumer<CreateQuoteBloc, CreateQuoteState>(
          builder: (context, state) {
            var bloc = context.read<CreateQuoteBloc>();
            return Row(
              children: [
                Flexible(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                          controller: bloc.authorController,
                          hint: 'Author',
                          margin: const EdgeInsets.only(
                              left: 24, right: 24, top: 24),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        width: size.width / 2,
                        child: Input(
                          controller: bloc.bodyController,
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
                                ...(state.userHashtags ?? []).mapIndexed(
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
                          disabled: state.status == CreateQuoteStatus.loading,
                          title: 'Create',
                          onClick: () {
                            bloc.add(CreateQuote());
                          },
                        ),
                        width: size.width / 2,
                      )
                    ],
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      state.hashTagPagingStatus ==
                              HashTagPagingStatus.initialPaging
                          ? Row(
                              children: [
                                Spacer(),
                                CircularProgressIndicator(),
                                Spacer()
                              ],
                            )
                          : CreateQuoteHashtagsListWidget(
                              onSelectHashTag: (hashtag) {
                                bloc.add(AddHashTag(hashtag: hashtag));
                              },
                            ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                ),
              ],
            );
          },
          listener: (context, state) {
            context.showSnackBar(state.message);
          },
        ),
      ),
    );
  }
}
