import 'package:flutter/material.dart';
import 'package:flutter_banking_app/utils/styles.dart';

class HorizontalSlideAdd extends StatelessWidget {
  const HorizontalSlideAdd({Key? key, required this.title, this.onPressed})
      : super(key: key);

  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(
            color: Styles.accentColor,
            fontWeight: FontWeight.w700,
            fontSize: 14,
            letterSpacing: 0.5),
      ),
      style: ElevatedButton.styleFrom(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(getProportionateScreenWidth(10))),
          primary: Styles.primaryColor),
    );
  }
}

class HorizontalSlider extends StatelessWidget {
  const HorizontalSlider({Key? key, this.onPressed, required this.title})
      : super(key: key);

  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(
            color: Styles.accentColor,
            fontWeight: FontWeight.w700,
            fontSize: 14,
            letterSpacing: 0.5),
      ),
      style: ElevatedButton.styleFrom(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(getProportionateScreenWidth(10))),
          primary: Styles.primaryColor),
    );
  }
}
