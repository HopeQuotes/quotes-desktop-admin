import 'dart:io';

import 'package:admin/common_widgets/button_widget.dart';
import 'package:admin/constants.dart';
import 'package:admin/di/injector.dart';
import 'package:admin/dialogs/content_split_by_enter_dialog.dart';
import 'package:admin/utils/array.dart';
import 'package:admin/utils/fonts.dart';
import 'package:admin/utils/print.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common_widgets/chip_item_widget.dart';
import '../../../common_widgets/input_widget.dart';
import 'bloc/create_quote_bloc.dart';
import 'create_quote_data_tabs_widget.dart';

class QuoteCreateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor,
      body: BlocProvider(
        create: (_) => CreateQuoteBloc(injector())
          ..add(LoadHashTags())
          ..add(LoadImages()),
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
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Spacer(),
                          Container(
                            padding: EdgeInsets.all(24),
                            alignment: Alignment.centerRight,
                            child: Button(
                              width: 152,
                              margin: EdgeInsets.all(0),
                              height: 56,
                              animate: false,
                              disabled: state.createQuoteStatus ==
                                  CreateQuoteStatus.loading,
                              title: 'Choose file',
                              onClick: () async {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles(
                                        type: FileType.custom,
                                        allowedExtensions: ["txt"]);

                                if (result != null) {
                                  showSelectContentSplitByDialog(context,
                                      result: (splitBy) {
                                    bloc.add(AnalyzeFile(
                                        path: result.files.single.path ?? "",
                                        splitBy: splitBy));
                                  });
                                }
                                // bloc.add(CreateQuotes());
                              },
                            ),
                          ),
                          Container(

                            padding: EdgeInsets.all(24),
                            alignment: Alignment.centerRight,
                            child: Button(
                              margin: EdgeInsets.only(right: 24),
                              width: 172,
                              height: 56,
                              disabled: state.createQuoteStatus ==
                                  CreateQuoteStatus.loading,
                              title: 'Create from content',
                              onClick: () {
                                bloc.add(CreateQuotes());
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(24),
                            alignment: Alignment.centerRight,
                            child: Button(
                              margin: EdgeInsets.only(right: 24),
                              width: 152,
                              height: 56,
                              disabled: state.createQuoteStatus ==
                                  CreateQuoteStatus.loading,
                              title: 'Create',
                              onClick: () {
                                bloc.add(CreateQuote());
                              },
                            ),
                          ),
                        ],
                      ),
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
                          : Container(
                              child: CreateQuoteDataTabsWidget(
                                onSelectImage: (image) {
                                  bloc.add(SetSelectedImageId(id: image.id));
                                },
                                onSelectHashTag: (hashtag) {
                                  bloc.add(AddHashTag(hashtag: hashtag));
                                },
                              ),
                              height: size.height * .8,
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
          listenWhen: (prev, curr) {
            return prev.message != curr.message;
          },
          listener: (context, state) {
            context.showSnackBar(state.message);
          },
        ),
      ),
    );
  }
}
