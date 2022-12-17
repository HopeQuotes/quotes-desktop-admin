import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

void baseDialogDialog(
    {required Widget content,
    required BuildContext context,
    Function? onDialogShow,
    Function? onDialogDismiss,
    bool barrierDismissible = true}) async {
  onDialogShow?.call();

  await showDialog(
    context: context,
    useSafeArea: false,

    barrierDismissible: barrierDismissible,
    builder: (_) {
      return AlertDialog(
        backgroundColor: primaryColor,
        contentPadding: EdgeInsets.all(12),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(24),
          ),
        ),
        content: Material(color: primaryColor, child: content),
      );
    },
  );
  onDialogDismiss?.call();
}
