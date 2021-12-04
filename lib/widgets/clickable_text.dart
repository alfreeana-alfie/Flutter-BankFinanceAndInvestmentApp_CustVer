import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class ClickableText extends StatefulWidget {
  const ClickableText(
      {required this.text,
      required this.selectedTextColor,
      required this.fontSize,
      required this.fontWeight,
      required this.tapGestureRecognizer,
      required this.margin,
      required this.alignment});

  final String text;
  final Color selectedTextColor;
  final double fontSize;
  final FontWeight fontWeight;
  final TapGestureRecognizer tapGestureRecognizer;
  final EdgeInsetsGeometry margin;
  final Alignment alignment;

  @override
  _ClickableTextState createState() => _ClickableTextState();
}

class _ClickableTextState extends State<ClickableText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: widget.alignment,
      margin: widget.margin,
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
              text: widget.text,
              style: TextStyle(
                color: widget.selectedTextColor,
                fontSize: widget.fontSize,
                fontWeight: widget.fontWeight,
              ),
              recognizer: widget.tapGestureRecognizer),
        ]),
      ),
    );
  }
}
