import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({
    required this.title,
    required this.textStyle,
    required this.alignment, 
    required this.margin
  });

  final String title;
  final TextStyle textStyle;
  final Alignment alignment;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      margin: margin,
      child: Text(
        title,
        style: textStyle,
      ),
    );
  }
}
