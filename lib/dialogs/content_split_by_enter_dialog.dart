import 'package:admin/common_widgets/button_widget.dart';
import 'package:admin/common_widgets/input_widget.dart';
import 'package:admin/constants.dart';
import 'package:admin/dialogs/base_dialog.dart';
import 'package:admin/utils/fonts.dart';
import 'package:flutter/cupertino.dart';

void showSelectContentSplitByDialog(BuildContext context,
    {required Function(String value) result}) {
  final controller = TextEditingController();
  final focus = FocusNode();
  focus.requestFocus();
  baseDialogDialog(
      content: Container(
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: primaryColor,
        ),
        margin: EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  "Enter split pattern",
                  style: getTextStyle(),
                ),
                Spacer(),
              ],
            ),
            Padding(padding: EdgeInsets.all(16)),
            Input(
              focusNode: focus,
              hint: 'example: ***',
              controller: controller,
              margin: EdgeInsets.only(top: 12),
            ),
            Padding(padding: EdgeInsets.all(16)),
            Button(
              width: double.infinity,
              height: 48,
              margin: EdgeInsets.all(4),
              title: 'Apply',
              onClick: () {
                result.call(controller.text);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      context: context);
}
