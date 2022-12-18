import 'package:admin/domain/models/ui/quote.dart';
import 'package:admin/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/fonts.dart';
import 'bloc/create_quote_bloc.dart';

class StatesScreen extends StatelessWidget {
  final Function(QuoteState)? onSelectImage;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocConsumer<CreateQuoteBloc, CreateQuoteState>(
      builder: (context, state) {
        var bloc = context.read<CreateQuoteBloc>();
        return Container(
          margin: EdgeInsets.only(top: 12),
          padding: EdgeInsets.all(2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white.withAlpha(6)),
          child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              childAspectRatio: 2,
              mainAxisSpacing: 1,
              crossAxisCount: 3,
              children: (state.quoteStates ?? [])
                  .map(
                    (e) => GestureDetector(
                      onTap: () {
                        context
                            .read<CreateQuoteBloc>()
                            .add(SetSelectedState(state: e));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white12)),
                        child: Row(
                          children: [
                            Icon(
                              e.id == state.selectedQuoteState?.id
                                  ? Icons.circle
                                  : Icons.circle_outlined,
                              size: 16,
                              color: HexColor.fromHex(e.color),
                            ),
                            Padding(padding: EdgeInsets.all(6)),
                            Text(
                              e.value,
                              style: getTextStyle(),
                            ),
                          ],
                        ),
                      ),
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

  const StatesScreen({
    this.onSelectImage,
  });
}
