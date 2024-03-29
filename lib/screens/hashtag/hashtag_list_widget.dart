import 'package:admin/di/injector.dart';
import 'package:admin/domain/models/ui/id_value.dart';
import 'package:admin/screens/hashtag/bloc/hashtag_bloc.dart';
import 'package:admin/screens/hashtag/widget/hashtag_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/hashtag_event.dart';
import 'bloc/hashtag_state.dart';

class HashtagListWidget extends StatelessWidget {
  final Function(IdValue)? onSelectHashTag;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocConsumer<HashtagBloc, HashtagState>(
      builder: (context, state) {
        var bloc = context.read<HashtagBloc>();
        return Container(
          padding: EdgeInsets.all(12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.white.withAlpha(6)),
          child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              childAspectRatio: 2.8,
              controller: bloc.hashtagScrollController,
              mainAxisSpacing: 2,
              crossAxisCount: 2,
              children: (state.hashtags ?? [])
                  .map((e) => HashTagItem(
                        onTap: () {
                          onSelectHashTag?.call(e);
                        },
                        text: e.value,
                      ))
                  .toList()),
          width: size.width * .35,
          height: size.height * .9,
        );
      },
      listener: (context, state) {
        //
      },
    );
  }

  const HashtagListWidget({
    this.onSelectHashTag,
  });
}
