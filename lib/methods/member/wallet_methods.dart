import 'package:flutter/material.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_banking_app/utils/api.dart';

import '../config.dart';

class WalletMethods {
  static void add(BuildContext context, Map<String, String> body) async {
    final response = await http.post(
      API.createWallet,
      headers: headers,
      body: body,
    );

    if (response.statusCode == Status.created) {
      CustomToast.showMsg(Status.successTxt, Styles.successColor);
      // Future.delayed(const Duration(milliseconds: 2000), () {

      //   Navigator.pushReplacementNamed(context, RouteSTR.exchangeMoneyListM);

      // });
    } else {
      print(response.body);
      // print(Status.failedTxt);
      CustomToast.showMsg(Status.failedTxt, Styles.dangerColor);
    }
  }

  static void update(BuildContext context, Map<String, String> body) async {
    final response = await http.post(
      API.updateWallet,
      headers: headers,
      body: body,
    );

    if (response.statusCode == Status.ok) {
      CustomToast.showMsg(Status.successTxt, Styles.successColor);
      // Future.delayed(const Duration(milliseconds: 2000), () {

      //   Navigator.pushReplacementNamed(context, RouteSTR.exchangeMoneyListM);

      // });
    } else {
      print(response.body);
      // print(Status.failedTxt);
      CustomToast.showMsg(Status.failedTxt, Styles.dangerColor);
    }
  }

  static void addTransaction(BuildContext context, Map<String, String> body) async {
    final response = await http.post(
      API.createWalletTransaction,
      headers: headers,
      body: body,
    );

    if (response.statusCode == Status.created) {
      CustomToast.showMsg(Status.successTxt, Styles.successColor);
      // Future.delayed(const Duration(milliseconds: 2000), () {

      //   Navigator.pushReplacementNamed(context, RouteSTR.exchangeMoneyListM);

      // });
    } else {
      print(response.body);
      // print(Status.failedTxt);
      CustomToast.showMsg(Status.failedTxt, Styles.dangerColor);
    }
  }

  static void updateTransaction(BuildContext context, Map<String, String> body) async {
    final response = await http.post(
      API.updateWalletTransaction,
      headers: headers,
      body: body,
    );

    if (response.statusCode == Status.ok) {
      CustomToast.showMsg(Status.successTxt, Styles.successColor);
      // Future.delayed(const Duration(milliseconds: 2000), () {

      //   Navigator.pushReplacementNamed(context, RouteSTR.exchangeMoneyListM);

      // });
    } else {
      print(response.body);
      // print(Status.failedTxt);
      CustomToast.showMsg(Status.failedTxt, Styles.dangerColor);
    }
  }
}
