import 'package:admin/constants.dart';
import 'package:admin/utils/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HashTagItem extends StatelessWidget {
  final String text;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.white.withAlpha(6),
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.05),
                blurRadius: 232,
                spreadRadius: 24,
                offset: const Offset(0, 0), // shadow direction: bottom right
              )
            ],
          ),
          margin: const EdgeInsets.all(12),
          child: Container(
            margin: const EdgeInsets.all(12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.numbers,
                  color: Colors.white,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 4),
                ),
                Text(
                  text,
                  style: getTextStyle(),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 4),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          print("click");
          onTap?.call();
        });
  }

  const HashTagItem({
    required this.text,
    this.onTap,
  });
}
