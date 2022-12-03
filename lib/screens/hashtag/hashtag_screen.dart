import 'package:admin/di/injector.dart';
import 'package:admin/screens/hashtag/bloc/hashtag_bloc.dart';
import 'package:admin/screens/hashtag/hashtag_list_widget.dart';
import 'package:admin/utils/print.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common_widgets/button_widget.dart';
import '../../common_widgets/input_widget.dart';
import '../../constants.dart';
import '../../utils/fonts.dart';

class HashtagScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (_) => HashtagBloc(injector()),
      child: BlocConsumer<HashtagBloc, HashtagState>(builder: (context, state) {
        return Scaffold(
          backgroundColor: primaryColor,
          body: SingleChildScrollView(
            child: Row(
              children: [
                Flexible(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Text(
                              "Create hashtag",
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
                          controller: context
                              .read<HashtagBloc>()
                              .hashTagValueController,
                          multiLine: true,
                          hint: 'Body...',
                          margin: const EdgeInsets.only(
                              left: 24, right: 24, top: 24),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(24),
                        alignment: Alignment.centerRight,
                        child: Button(
                          width: 152,
                          height: 56,
                          disabled:
                              state.createStatus == HashTagCreateStatus.loading,
                          title: 'Create',
                          onClick: () {
                            context.read<HashtagBloc>().add(CreateHashtag());
                          },
                        ),
                        width: size.width / 2,
                      )
                    ],
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: HashtagListWidget(),
                ),
              ],
            ),
          ),
        );
      }, listener: (context, state) {
        if (state.createStatus == HashTagCreateStatus.success) {
          context.showSnackBar(state.createHashtagMessage);
        }
        if (state.createStatus == HashTagCreateStatus.fail) {
          context.showSnackBar(state.createHashtagMessage);
        }
      }),
    );
  }
}
