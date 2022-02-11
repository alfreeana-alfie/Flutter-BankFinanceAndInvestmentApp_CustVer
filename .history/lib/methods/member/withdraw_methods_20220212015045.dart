
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_banking_app/utils/api.dart';

class WithdrawMethods {
  static void add(BuildContext context, Map<String, String> body) async {
    final response = await http.post(
      API.createWithdraw,
      headers: headers,
      body: body,
    );

    if (response.statusCode == Status.created) {
      // print(Status.success);
      CustomToast.showMsg(Status.success, Styles.successColor);
      Future.delayed(const Duration(milliseconds: 2000), () {

        Navigator.pushReplacementNamed(context, RouteSTR.withdrawListM);

      });
    } else {
      print(response.body);
      CustomToast.showMsg(Status.failed, Styles.dangerColor);
    }
  }

  static void update(BuildContext context, Map<String, String> body) async {
    final response = await http.post(
      API.wireTransfer,
      headers: headers,
      body: body,
    );

    if (response.statusCode == Status.created) {
      // print(Status.success);
      CustomToast.showMsg(Status.success, Styles.successColor);
      Future.delayed(const Duration(milliseconds: 2000), () {

        Navigator.pushReplacementNamed(context, RouteSTR.with);

      });
    } else {
      print(response.body);
      CustomToast.showMsg(Status.failed, Styles.dangerColor);
    }
  }
}
