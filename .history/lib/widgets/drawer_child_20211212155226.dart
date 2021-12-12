import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/utils/values.dart';

import 'clickable_text.dart';

class DrawerChild extends StatelessWidget {
  const DrawerChild({required this.title, required this.onNavigate});

  final String title;
  final TapGestureRecognizer onNavigate;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Values.drawerMargin,
      child: ClickableText(
          text: title,
          selectedTextColor: Styles.textColor.withOpacity(0.7),
          fontSize: 15,
          fontWeight: FontWeight.w400,
          tapGestureRecognizer: onNavigate,
          margin: const EdgeInsets.symmetric(
              horizontal: Values.horizontalValue, vertical: 5),
          alignment: Alignment.centerLeft),
    );
  }
}
