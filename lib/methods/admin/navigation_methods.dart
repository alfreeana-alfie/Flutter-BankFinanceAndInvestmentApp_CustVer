
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:http/http.dart' as http;

import '../config.dart';

class NavigationMethods {
  static void add(BuildContext context, Map<String, String> body) async {
    final response = await http.post(
      AdminAPI.createNavigation,
      headers: headers,
      body: body,
    );

    if (response.statusCode == Status.created) {
      print(Status.successTxt);
      CustomToast.showMsg(Status.successTxt, Styles.successColor);
      Navigator.pop(context);
    } else {
      print(Status.failedTxt);
      CustomToast.showMsg(Status.failedTxt, Styles.dangerColor);
    }
  }

  static void addItem(BuildContext context, Map<String, String> body) async {
    final response = await http.post(
      AdminAPI.createNavigationItem,
      headers: headers,
      body: body,
    );

    if (response.statusCode == Status.created) {
      print(Status.successTxt);
      CustomToast.showMsg(Status.successTxt, Styles.successColor);
      Navigator.pop(context);
    } else {
      print(Status.failedTxt);
      CustomToast.showMsg(Status.failedTxt, Styles.dangerColor);
    }
  }
}