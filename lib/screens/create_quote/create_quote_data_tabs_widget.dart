import 'package:admin/constants.dart';
import 'package:admin/domain/models/ui/image.dart';
import 'package:admin/screens/create_quote/states_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/ui/id_value.dart';
import '../../../utils/fonts.dart';
import 'bloc/create_quote_bloc.dart';
import 'file_content_screen.dart';
import 'hashtags_screen.dart';
import 'images_screen.dart';

class CreateQuoteDataTabsWidget extends StatefulWidget {
  final Function(IdValue)? onSelectHashTag;
  final Function(QuoteImage)? onSelectImage;

  @override
  State<CreateQuoteDataTabsWidget> createState() =>
      _CreateQuoteDataTabsWidgetState();

  const CreateQuoteDataTabsWidget({this.onSelectHashTag, this.onSelectImage});
}

class _CreateQuoteDataTabsWidgetState extends State<CreateQuoteDataTabsWidget>
    with TickerProviderStateMixin {
  var screens = [];

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    screens = [
      HashtagsScreen(
        onSelectHashTag: widget.onSelectHashTag,
      ),
      ImagesScreen(
        onSelectImage: widget.onSelectImage,
      ),
      FileContentScreen(),
      StatesScreen(),
    ];
    super.initState();
  }

  var screenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateQuoteBloc, CreateQuoteState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: primaryColor,
          body: screens[screenIndex],
          appBar: TabBar(
            indicatorColor: primaryColor,
            labelStyle: getTextStyle(),
            splashBorderRadius: BorderRadius.circular(16),
            unselectedLabelColor: Colors.white.withAlpha(52),
            indicator: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: primaryLightColor),
            isScrollable: false,
            controller: _tabController,
            onTap: (index) {
              setState(() {
                screenIndex = index;
              });
            },
            tabs: [
              Tab(
                text: "Hashtags",
              ),
              Tab(
                text: "Images",
              ),
              Tab(
                text: "File",
              ),
              Tab(
                text: "States",
              )
            ],
          ),
        );
      },
      listener: (context, state) {
        //
      },
    );
  }
}
