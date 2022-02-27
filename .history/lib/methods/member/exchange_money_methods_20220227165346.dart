import '../config.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExchangeMoneyMethods {
  static void add(BuildContext context, Map<String, String> body) async {
    final response = await http.post(
      API.exchangeMoney,
      headers: headers,
      body: body,
    );

    if (response.statusCode == Status.created) {
      // CustomToast.showMsg(Status.success, Styles.successColor);
      // Future.delayed(const Duration(milliseconds: 2000), () {

      //   Navigator.pushReplacementNamed(context, RouteSTR.exchangeMoneyListM);

      // });
    } else {
      print(response.body);
      // print(Status.failed);
      CustomToast.showMsg(Status.failed, Styles.dangerColor);
    }
  }
}
