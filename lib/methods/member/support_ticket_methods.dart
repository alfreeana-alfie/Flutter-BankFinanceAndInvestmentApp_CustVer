import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_banking_app/utils/api.dart';

class SupportTicketMethods {
  static void add(BuildContext context, Map<String, String> body) async {
    final response = await http.post(
      API.createSupportTicket,
      headers: headers,
      body: body,
    );

    if (response.statusCode == Status.ok) {
      // print(Status.successTxt);
      CustomToast.showMsg(Status.successTxt, Styles.successColor);
      Navigator.pop(context);
    } else {
      // print(Status.failedTxt);
      CustomToast.showMsg(Status.failedTxt, Styles.dangerColor);
    }
  }

}
