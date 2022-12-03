import 'package:admin/common_widgets/chip_item_widget.dart';
import 'package:admin/di/injector.dart';
import 'package:admin/models/id_value.dart';
import 'package:admin/screens/hashtag/bloc/hashtag_bloc.dart';
import 'package:admin/screens/hashtag/widget/hashtag_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HashtagListWidget extends StatelessWidget {
  final Function(IdValue)? onSelectHashTag;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (_) => injector.get<HashtagBloc>()..add(LoadHashTags()),
      child: BlocConsumer<HashtagBloc, HashtagState>(
        builder: (context, state) {
          var bloc = context.read<HashtagBloc>();
          return Container(
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
                            print("click 2");
                          },
                          text: e.value,
                        ))
                    .toList()),
            width: size.width * .3,
            height: size.height * 0.9,
          );
        },
        listener: (context, state) {
          //
        },
      ),
    );
  }

  const HashtagListWidget({
    this.onSelectHashTag,
  });
}
