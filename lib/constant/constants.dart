import 'package:flutter/material.dart';

const double horizontalValue = 15;
const double verticalValue = 10;
const double homeSecondContainer = 100;

EdgeInsetsGeometry defaultMargin = const EdgeInsets.symmetric(
    horizontal: horizontalValue, vertical: verticalValue);
EdgeInsetsGeometry marginGotoSignIn =
    const EdgeInsets.only(top: 20, bottom: 50);
EdgeInsetsGeometry marginLabel = const EdgeInsets.only(
    left: horizontalValue, right: horizontalValue, top: 10);
EdgeInsetsGeometry spacerVertical = const EdgeInsets.symmetric(vertical: 10);

const divider = Divider(thickness: 1.0);

const spacer = SizedBox(height: 15);

const spacerWidth = SizedBox(width: 15);

const Map<String, String> headers = {"Accept": "application/json"};
