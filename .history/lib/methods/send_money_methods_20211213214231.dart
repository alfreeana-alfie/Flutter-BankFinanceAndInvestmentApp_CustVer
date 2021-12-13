import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_banking_app/utils/api.dart';

SharedPref sharedPref = SharedPref();

void sendMoney(BuildContext context, Map<String, String> body) async {
  final response = await http.post(
    API.sendMoney,
    headers: API.headers,
    body: body,
  );

  if (response.statusCode == ApiSTR.) {
    print(ApiSTR.successTxt);
  } else {
    print(ApiSTR.failedTxt);
  }
}
