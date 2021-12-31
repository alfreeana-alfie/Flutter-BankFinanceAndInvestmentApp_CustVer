import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/bottom_nav_int.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_banking_app/utils/api.dart';

class FixedDepositMethods {
  static void add(
      BuildContext context, Map<String, String> body, String filename) async {
    final response = await http.post(
      API.fixedDeposit,
      headers: headers,
      body: body,
    );
    // final request = http.MultipartRequest('POST', API.fixedDeposit)
    //   ..fields.addAll(body)
    //   ..headers.addAll(headersMultiPart)
    //   ..files.add(await http.MultipartFile.fromPath(
    //       'fixed_deposit_files', filename));

    // var response = await request.send();

    if (response.statusCode == Status.created) {
      // print(Status.successTxt);
      CustomToast.showMsg(Status.successTxt, Styles.successColor);
      Future.delayed(const Duration(milliseconds: 2000), () {
        Navigator.pushReplacementNamed(context, RouteSTR.fdrListM);
      });
    } else {
      print(response.body);
      CustomToast.showMsg(Status.failedTxt, Styles.dangerColor);
    }
  }
}
