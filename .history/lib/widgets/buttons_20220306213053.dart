import 'package:flutter/material.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

Widget elevatedButton(
    {required BuildContext context,
    required VoidCallback callback,
    required String text,
    Color? color}) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
        child: Text(text),
        style: ElevatedButton.styleFrom(
            primary: color ?? Styles.primaryColor,
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
            padding: const EdgeInsets.symmetric(vertical: 15),
            textStyle: const TextStyle(
                fontFamily: 'DMSans',
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 17)),
        onPressed: callback),
  );
}

Widget elevatedButtonWithGraphic(
    {required BuildContext context,
    required void Function()? callback,
    required RoundedLoadingButtonController controller,
    required Widget child,
    Color? color}) {
  return SizedBox(
    width: double.infinity,
    child: RoundedLoadingButton(
        controller: controller,
        child: child,
        color: Styles.secondaryColor,
        width: getProportionateScreenWidth(300),
        borderRadius: 7,
        elevation: 0.0,
        onPressed: callback),
  );
}

Widget outlinedButton(
    {required BuildContext context,
    required VoidCallback callback,
    required Widget child,
    String? color}) {
  return OutlinedButton(
    onPressed: callback,
    child: child,
    style: OutlinedButton.styleFrom(
      backgroundColor: Colors.transparent,
      primary: Styles.primaryColor,
      elevation: 0,
      side: BorderSide(color: Colors.grey.shade400, width: 1),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(getProportionateScreenWidth(10))),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
    ),
  );
}

final RoundedLoadingButtonController _btnController =
    RoundedLoadingButtonController();

Widget loadingButton(
    {required BuildContext context,
    required VoidCallback callback,
    required String text,
    Color? color}) {
  return Container(
    // margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
    child: RoundedLoadingButton(
      color: Styles.secondaryColor,
      width: getProportionateScreenWidth(300),
      borderRadius: 10,
      child: Text(text),
      controller: _btnController,
      onPressed: callback,
    ),
  );
}

Widget backButton(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(Str.back.toUpperCase()),
      style: ElevatedButton.styleFrom(
        primary: Styles.dangerColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        padding: const EdgeInsets.symmetric(vertical: 15),
        textStyle: const TextStyle(
                fontFamily: 'DMSans',
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 17)
      ),
    ),
  );
}
