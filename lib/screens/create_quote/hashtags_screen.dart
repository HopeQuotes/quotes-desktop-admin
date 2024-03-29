import 'package:admin/domain/models/ui/id_value.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../hashtag/widget/hashtag_item.dart';
import 'bloc/create_quote_bloc.dart';

class HashtagsScreen extends StatelessWidget {
  final Function(IdValue)? onSelectHashTag;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocConsumer<CreateQuoteBloc, CreateQuoteState>(
      builder: (context, state) {
        var bloc = context.read<CreateQuoteBloc>();
        return Container(
          margin: EdgeInsets.only(top: 12),
          padding: EdgeInsets.all(12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
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

  HashtagsScreen({
    this.onSelectHashTag,
  });
}
