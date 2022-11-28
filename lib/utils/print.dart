import 'package:admin/constants.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'fonts.dart';

enum MessageStatus { success, fail, informative }

extension ContextExt on BuildContext {
  void showSnackBar(String? message,
      {MessageStatus status = MessageStatus.success}) {
    if (message != null) {
      Color backColor = primaryLightColor;

      if (status == MessageStatus.fail) {
        backColor = primaryRedColor;
      }

      Flushbar(
        maxWidth: 400,
        flushbarPosition: FlushbarPosition.TOP,
        duration: const Duration(seconds: 2),
        messageSize: 16,
        messageText: Text(
          message,
          style: getTextStyle(),
        ),
        backgroundColor: backColor,
        borderRadius: BorderRadius.circular(16),
        margin: EdgeInsets.all(32),
      ).show(this);
    }
  }
}

void printMessage(String? message) {
  if (kDebugMode) {
    print(message);
  }
}
