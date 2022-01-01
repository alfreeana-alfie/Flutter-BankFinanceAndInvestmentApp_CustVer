import 'package:flutter/material.dart';
import 'package:flutter_banking_app/utils/size_config.dart';

class Styles {
  static String formatDate = 'yyyy-MM-dd hh:mm:ss';
  // LIGHT MODE
  static const Color primaryColor = Color.fromRGBO(255, 255, 255, 1);
  static const Color primaryWithOpacityColor =
      Color.fromRGBO(102, 153, 255, 0.3);
  static const Color accentColor = Color.fromRGBO(0, 51, 153, 1);
  static const Color secondaryColor = Color.fromRGBO(0, 122, 254, 1);
  static const Color thirdColor = Color.fromRGBO(102, 153, 255, 1);
  static const Color yellowColor = Color.fromRGBO(223, 233, 75, 1);
  static const Color textColor = Color.fromRGBO(33, 34, 42, 1);
  static const Color textColorWhite = Color.fromRGBO(255, 255, 255, 1);

  // DARK MODE
  static Color primaryColorDark = const Color(0xFF161D28);
  static Color primaryWithOpacityColorDark = const Color(0xFF212E3E);
  static Color yellowColorDark = const Color(0xFFDFE94B);
  static Color accentColorDark = const Color(0xFF024751);

  static Color greyColor = const Color(0xFFDFE1E3);
  static const cardColor = Color.fromRGBO(255, 255, 255, 1);
  static Color buttonColor = const Color(0xFF4C66EE);
  static Color blueColor = const Color(0xFF4BACF7);
  static const Color whiteColor = Color.fromRGBO(255, 255, 255, 1);

  static Color textColorDark = const Color.fromRGBO(255, 255, 255, 1);
  static const Color darkBlueColor = Color.fromRGBO(29, 39, 68, 1);
  static const Color backgroundColor = Color.fromRGBO(242, 242, 242, 1);

  static const Color dangerColor = Color.fromRGBO(245, 54, 92, 1);
  static const Color warningColor = Color.fromRGBO(251, 99, 64, 1);
  static const Color successColor = Color.fromRGBO(45, 206, 137, 1);
  static const Color infoColor = Color.fromRGBO(17, 205, 239, 1);

  static const Color transparentColor = Color.fromRGBO(0, 0, 0, 0);

  static const TextStyle primaryTitle = TextStyle(
      color: Styles.textColor, fontSize: 16, fontWeight: FontWeight.bold);

  static TextStyle textStyle =
      TextStyle(fontSize: getProportionateScreenWidth(15));
  static TextStyle titleStyle = TextStyle(
      fontFamily: 'DMSans',
      fontSize: getProportionateScreenWidth(19),
      fontWeight: FontWeight.w500);

  static const TextStyle headingStyle01 = TextStyle(
      fontWeight: FontWeight.w500, fontSize: 19, color: Styles.textColorWhite);
  static const TextStyle titleApp = TextStyle(
      fontWeight: FontWeight.w500, fontSize: 19, color: Styles.textColor);

  static const TextStyle subtitleStyle = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 21, color: Styles.textColorWhite);
  static const TextStyle subtitleStyle02 = TextStyle(
      color: Styles.textColorWhite, fontSize: 18, fontWeight: FontWeight.bold);
  static TextStyle subtitleStyle03 = TextStyle(
      color: Styles.textColorWhite.withOpacity(0.7),
      fontSize: getProportionateScreenWidth(18),
      fontWeight: FontWeight.bold);

  static TextStyle subtitleStyleDark = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: getProportionateScreenWidth(21),
      color: Colors.black);
  static const TextStyle subtitleStyleDark02 =
      TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold);
  static const TextStyle subtitleStyleDark03 = TextStyle(
      color: Color.fromRGBO(0, 0, 0, 0.7),
      fontSize: 18,
      fontWeight: FontWeight.bold);

  static const TextStyle cardDetails = TextStyle(
      color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal);
  static const TextStyle cardTitle =
      TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold);

  static ThemeData light = ThemeData(
      backgroundColor: Styles.primaryColor,
      textTheme: const TextTheme(
          bodyText1: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 21,
              color: Styles.textColor)));

  static ThemeData dark = ThemeData(
      backgroundColor: Styles.primaryColorDark,
      textTheme: TextTheme(
          bodyText1: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 21,
              color: Styles.textColorDark)));
}
