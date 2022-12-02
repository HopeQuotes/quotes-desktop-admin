import 'package:flutter/cupertino.dart';

extension ScrollControllerExt on ScrollController {
  void onBottomReached(Function() onReached) {
    addListener(() async {
      if (position.atEdge) {
        bool isTop = position.pixels == 0;
        if (isTop) {
          //
        } else {
          onReached.call();
        }
      }
    });
  }
}
