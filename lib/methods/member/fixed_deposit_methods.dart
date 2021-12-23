
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_banking_app/utils/api.dart';

class FixedDepositMethods {
  static void add(BuildContext context, Map<String, String> body, String filename) async {
    // final response = await http.post(
    //   API.fixedDeposit,
    //   headers: API.headers,
    //   body: body,
    // );
    final request = http.MultipartRequest('POST', API.fixedDeposit)
      ..fields.addAll(body)
      ..headers.addAll(headersMultiPart)
      ..files.add(await http.MultipartFile.fromPath(
          'fixed_deposit_files', filename));

    var response = await request.send();

    if (response.statusCode == Status.created) {
      // print(Status.successTxt);
      CustomToast.showMsg(Status.successTxt, Styles.successColor);
      Navigator.pop(context);
    } else {
      // print(Status.failedTxt);
      CustomToast.showMsg(Status.failedTxt, Styles.dangerColor);
    }
  }

  static void viewAll() async {
    final response =
        await http.get(API.listOfFixedDeposit, headers: headers);

    if (response.statusCode == Status.ok) {
      // var jsonBody = jsonDecode(response.body);

      // for (var userData in jsonBody[Field.data]) {
      //   // print(userData);
      // }
    } else {
      // print(Status.failedTxt);
      CustomToast.showMsg(Status.failedTxt, Styles.dangerColor);
    }
  }

  static void viewOne(String userId) async {
    Uri viewSingleUser =
        Uri.parse(API.userFixedDepositList.toString() + userId);
    final response = await http.get(viewSingleUser, headers: headers);

    if (response.statusCode == Status.ok) {
      // var jsonBody = jsonDecode(response.body);

      // for (var userData in jsonBody[Field.data]) {
      //   // print(userData);
      // }
    } else {
      // print(Status.failedTxt);
      CustomToast.showMsg(Status.failedTxt, Styles.dangerColor);
    }
  }
}
