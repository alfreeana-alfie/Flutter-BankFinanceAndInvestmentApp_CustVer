import 'package:flutter/material.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:http/http.dart' as http;

import '../config.dart';

class RateMethods {
  static void add(BuildContext context, Map<String, String> body) async {
    final response = await http.post(
      AdminAPI.createDeposit,
      headers: headers,
      body: body,
    );

    if (response.statusCode == Status.created) {
      print(Status.successTxt);
      CustomToast.showMsg(Status.successTxt, Styles.successColor);
      Future.delayed(const Duration(milliseconds: 2000), () {

        Navigator.pushReplacementNamed(context, RouteSTR.depositList);

      });
    } else {
      print(Status.failedTxt);
      CustomToast.showMsg(Status.failedTxt, Styles.dangerColor);
    }
  }

  static void edit(BuildContext context, Map<String, String> body, String id) async {
    Uri url =
        Uri.parse(AdminAPI.updateDeposit.toString() + id);

    final response = await http.put(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == Status.ok) {
      // print(Status.successTxt);
      CustomToast.showMsg(Status.successTxt, Styles.successColor);
      Future.delayed(const Duration(milliseconds: 2000), () {

        Navigator.pushReplacementNamed(context, RouteSTR.depositList);

      });
    } else {
      print(Status.failedTxt);
      CustomToast.showMsg(Status.failedTxt, Styles.dangerColor);
    }
  }
  
  static void delete(BuildContext context, String id) async {
    Uri url =
        Uri.parse(AdminAPI.deleteDeposit.toString() + id);

    final response = await http.delete(
      url,
      headers: headers
    );

    if (response.statusCode == Status.ok) {
      CustomToast.showMsg(Status.successTxt, Styles.successColor);
    } else {
      print(Status.failedTxt);
      CustomToast.showMsg(Status.failedTxt, Styles.dangerColor);
    }
  }
}
