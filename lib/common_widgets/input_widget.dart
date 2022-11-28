import 'package:admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Input extends StatelessWidget {
  final String hint;
  final EdgeInsets margin;
  bool multiLine = false;
  final FocusNode? focusNode;
  double verticalPadding = 0.0;
  double blur;
  double spread;
  final TextEditingController? controller;
  final Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: margin,
      child: TextField(
        onSubmitted: (str) {
          onSubmit?.call(str);
        },
        focusNode: focusNode,
        keyboardType: multiLine ? TextInputType.multiline : TextInputType.name,
        maxLines: multiLine ? null : 1,
        textAlign: TextAlign.start,
        controller: controller,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
          hintText: hint,
          hintStyle: GoogleFonts.nunito(fontSize: 16, color: Colors.white60),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.white60,
              style: BorderStyle.solid,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(
              width: 2,
              color: Colors.white12,
              style: BorderStyle.solid,
            ),
          ),
          filled: true,
          contentPadding: EdgeInsets.only(
              left: 20,
              bottom: verticalPadding,
              top: verticalPadding,
              right: 20),
          fillColor: primaryLightColor,
        ),
      ),
    );
  }

  Input({
    required this.hint,
    this.multiLine = false,
    this.verticalPadding = 20,
    this.focusNode,
    this.controller,
    this.blur = 200.0,
    this.onSubmit,
    this.spread = 12.0,
    required this.margin,
  });
}
