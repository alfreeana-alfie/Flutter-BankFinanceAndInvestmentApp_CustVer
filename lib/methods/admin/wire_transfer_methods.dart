import 'package:flutter/material.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:http/http.dart' as http;

import '../config.dart';

class WireTransferMethods {
  static void add(BuildContext context, Map<String, String> body) async {
    final response = await http.post(
      AdminAPI.createWireTransfer,
      headers: headers,
      body: body,
    );

    if (response.statusCode == Status.created) {
      // print(Status.successTxt);
      CustomToast.showMsg(Status.successTxt, Styles.successColor);
      Future.delayed(const Duration(milliseconds: 2000), () {

        Navigator.pushReplacementNamed(context, RouteSTR.wireTransferList);

      });
    } else {
      // print(Status.failedTxt);
      CustomToast.showMsg(Status.failedTxt, Styles.dangerColor);
    }
  }

  static void editStatus(BuildContext context, Map<String, String> body, String id) async {
     Uri url =
        Uri.parse(AdminAPI.updateWireTransferStatus.toString() + id);

    final response = await http.put(
      url,
      headers: headers,
      body: body,
    );


    if (response.statusCode == Status.created) {
      // print(Status.successTxt);
      CustomToast.showMsg(Status.successTxt, Styles.successColor);
      Future.delayed(const Duration(milliseconds: 2000), () {

        Navigator.pushReplacementNamed(context, RouteSTR.wireTransferList);

      });
    } else {
      // print(Status.failedTxt);
      CustomToast.showMsg(Status.failedTxt, Styles.dangerColor);
    }
  }

  // static void edit(BuildContext context, Map<String, String> body, String id) async {
  //    Uri url =
  //       Uri.parse(AdminAPI.updateWireTransfer.toString() + id);

  //   final response = await http.put(
  //     url,
  //     headers: headers,
  //     body: body,
  //   );


  //   if (response.statusCode == Status.created) {
  //     // print(Status.successTxt);
  //     CustomToast.showMsg(Status.successTxt, Styles.successColor);
  //     Future.delayed(const Duration(milliseconds: 2000), () {

  //       Navigator.pushReplacementNamed(context, RouteSTR.currencyList);

  //     });
  //   } else {
  //     // print(Status.failedTxt);
  //     CustomToast.showMsg(Status.failedTxt, Styles.dangerColor);
  //   }
  // }
}