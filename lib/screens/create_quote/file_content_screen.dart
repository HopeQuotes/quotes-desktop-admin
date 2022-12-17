import 'package:admin/screens/quotes/widgets/quote_item_widget.dart';
import 'package:admin/utils/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/create_quote_bloc.dart';

class FileContentScreen extends StatelessWidget {
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
          child: (state.fileContent?.isNotEmpty == true)
              ? ListView.builder(
                  primary: false,
                  itemCount: (state.fileContent?.length ?? 0),
                  padding: const EdgeInsets.all(20),
                  itemBuilder: (e, i) {
                    return Container(
                      margin: EdgeInsets.all(12),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white12)),
                      child: Text(
                        state.fileContent![i].trim(),
                        style: getTextStyle(),
                      ),
                    );
                  },
                )
              : IconButton(
                  icon: Icon(
                    Icons.text_snippet,
                    size: 72,
                    color: Colors.white12,
                  ),
                  onPressed: () {
                    // context.read<CreateQuoteBloc>().add(Pick)
                  },
                ),
          width: size.width * .35,
          height: size.height * .9,
        );
      },
      listener: (context, state) {
        //
      },
    );
  }
}
