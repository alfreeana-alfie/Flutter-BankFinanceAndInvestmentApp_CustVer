import 'package:flutter/material.dart';
import 'package:flutter_banking_app/utils/size_config.dart';

class Styles {
  static Color primaryColor = const Color(0xFF161D28);
  static Color primaryWithOpacityColor = const Color(0xFF212E3E);
  static Color yellowColor = const Color(0xFFDFE94B);
  static Color accentColor = const Color(0xFF024751);
  static Color greyColor = const Color(0xFFDFE1E3);
  static Color buttonColor = const Color(0xFF4C66EE);
  static Color blueColor = const Color(0xFF4BACF7);
  static TextStyle textStyle =
      TextStyle(fontSize: getProportionateScreenWidth(15));
  static TextStyle titleStyle = TextStyle(
      fontFamily: 'DMSans',
      fontSize: getProportionateScreenWidth(19),
      fontWeight: FontWeight.w500);
  static const TextStyle subtitleStyle =
      TextStyle(
        fontWeight: FontWeight.bold, 
        fontSize: 21, 
        color: Colors.white);
  static const TextStyle subtitleStyle02 =
      TextStyle(
        color: Colors.white, 
        fontSize: 18, 
        fontWeight: FontWeight.bold
      );
  static TextStyle subtitleStyle03 =
      TextStyle(
        color: const Color.fromRGBO(255, 255, 255, 0.7), 
        fontSize: getProportionateScreenWidth(18), 
        fontWeight: FontWeight.bold
      );

  static TextStyle subtitleStyleDark =
      TextStyle(
        fontWeight: FontWeight.bold, 
        fontSize: getProportionateScreenWidth(21), 
        color: Colors.black);
  static const TextStyle subtitleStyleDark02 =
      TextStyle(
        color: Colors.black, 
        fontSize: 18, 
        fontWeight: FontWeight.bold);
  static const TextStyle subtitleStyleDark03 =
      TextStyle(
        color: const Color.fromRGBO(0, 0, 0, 0.7), 
        fontSize: getProportionateScreenWidth(18), 
        fontWeight: FontWeight.bold
      );

  static const TextStyle cardDetails =
      TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal);
  static const TextStyle cardTitle =
      TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold);

  static const Color whiteColor = Color.fromRGBO(255, 255, 255, 1);
  static const Color secondaryColor = Color.fromRGBO(0, 122, 254, 1);
  static const Color textColor = Color.fromRGBO(33, 34, 42, 1);
  static const Color darkBlueColor = Color.fromRGBO(29, 39, 68, 1);
  static const Color backgroundColor = Color.fromRGBO(242, 242, 242, 1);

  static const Color dangerColor = Color.fromRGBO(245, 54, 92, 1);
  static const Color warningColor = Color.fromRGBO(251, 99, 64, 1);
  static const Color successColor = Color.fromRGBO(45, 206, 137, 1);
  static const Color infoColor = Color.fromRGBO(17, 205, 239, 1);

  static const Color transparentColor = Color.fromRGBO(0, 0, 0, 0);
}
