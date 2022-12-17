import 'package:admin/domain/models/ui/image.dart';
import 'package:admin/screens/create_quote/widgets/quote_image_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/create_quote_bloc.dart';

class ImagesScreen extends StatelessWidget {
  final Function(QuoteImage)? onSelectImage;

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
              childAspectRatio: 1,
              mainAxisSpacing: 2,
              crossAxisCount: 2,
              children: (state.images ?? [])
                  .map(
                    (e) => QuoteImageItemWidget(
                      image:
                          e.copyWith(isSelected: state.selectedImageId == e.id),
                      onSelectImage: onSelectImage,
                    ),
                  )
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

  const ImagesScreen({
    this.onSelectImage,
  });
}
