import 'package:flutter/material.dart';

void baseBottomDialog(
    {required BuildContext context, required Widget content}) async {
  await showModalBottomSheet(
    context: context,
    builder: (context) {
      return content;
    },
  );
}
