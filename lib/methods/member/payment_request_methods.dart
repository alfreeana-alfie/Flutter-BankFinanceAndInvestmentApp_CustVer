
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_banking_app/utils/api.dart';

import '../config.dart';

class PaymentRequestMethods {
  static void add(BuildContext context, Map<String, String> body) async {
    final response = await http.post(
      API.paymentRequest,
      headers: headers,
      body: body,
    );

    if (response.statusCode == Status.created) {
      // print(Status.successTxt);
      CustomToast.showMsg(Status.successTxt, Styles.successColor);
    } else {
      // print(Status.failedTxt);
      CustomToast.showMsg(Status.failedTxt, Styles.dangerColor);
    }
  }

  static void viewAll() async {
    final response = await http.get(API.listOfPaymentRequest, headers: headers);

    if (response.statusCode == Status.ok) {
      // var jsonBody = jsonDecode(response.body);

      // for (var userData in jsonBody[Field.data]) {
      //   // print(userData);
      // }
    } else {
      // print(Status.failedTxt);
    }
  }

  static void viewOne(String userId) async {
    Uri viewSingleUser =
        Uri.parse(API.userPaymentRequestList.toString() + userId);
    final response = await http.get(viewSingleUser, headers: headers);

    if (response.statusCode == Status.ok) {
      // var jsonBody = jsonDecode(response.body);

      // for (var userData in jsonBody[Field.data]) {
      //   // print(userData);
      // }
    } else {
      // print(Status.failedTxt);
    }
  }
}
