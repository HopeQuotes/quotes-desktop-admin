import 'package:admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatefulWidget {
  final String title;
  final bool? disabled;
  final bool? animate;
  final Function onClick;
  final EdgeInsets? margin;
  final double? width;
  final double? height;

  @override
  State<Button> createState() => _ButtonState();

  const Button({
    required this.title,
    required this.onClick,
    this.disabled = false,
    this.animate = true,
    this.margin,
    this.width,
    this.height,
  });
}

class _ButtonState extends State<Button> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      margin: widget.margin ?? const EdgeInsets.all(24),
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: primaryLightColor ,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        child: Container(
          alignment: Alignment.center,
          child: widget.disabled != true
              ? Text(
                  widget.title,
                  style: GoogleFonts.nunito(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )
              : widget.animate == true
                  ? SpinKitWave(
                      color: Colors.white,
                      size: 20.0,
                      controller: _animationController,
                    )
                  : Text(
                      widget.title,
                      style: GoogleFonts.nunito(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
        ),
        onTap: () {
          if (widget.disabled != true) widget.onClick.call();
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
