import 'package:admin/common_widgets/input_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChipItemAdd extends StatefulWidget {
  final Function(String) onClick;

  @override
  State<ChipItemAdd> createState() => _ChipItemState();

  ChipItemAdd({
    required this.onClick,
  });
}

class _ChipItemState extends State<ChipItemAdd> {
  final TextEditingController _hashTagController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(20),
          child: Input(
            controller: _hashTagController,
            hint: 'Hashtag...',
            margin: EdgeInsets.all(12),
          ),
          width: 200,
          height: 82,
        ),
        InkWell(
          borderRadius: BorderRadius.circular(24),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.05),
                  blurRadius: 232,
                  spreadRadius: 24,
                  offset: const Offset(0, 0), // shadow direction: bottom right
                )
              ],
            ),
            child: Container(
              margin: const EdgeInsets.all(12),
              child: Icon(
                Icons.add,
                color: Colors.indigo,
              ),
            ),
          ),
          onTap: () {
            if (_hashTagController.text.trim().isNotEmpty) {
              widget.onClick.call(_hashTagController.text);
              _hashTagController.clear();
            }
          },
        ),
      ],
    );
  }
}
