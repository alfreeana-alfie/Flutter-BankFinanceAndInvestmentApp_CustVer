import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/transaction.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_banking_app/utils/api.dart';

class SendMoneyMethods {
  static void add(BuildContext context, Map<String, String> body) async {
    final response = await http.post(
      API.sendMoney,
      headers: API.headers,
      body: body,
    );

    if (response.statusCode == Status.created) {
      print(Status.successTxt);
    } else {
      print(Status.failedTxt);
    }
  }

  static void viewAll() async {
    final response = await http.get(API.listOfSendMoney, headers: API.headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);
      print(jsonBody);
      for (var userData in userMap['data']) {
          final users = User.fromMap(userData);

          setState(() {
            userList.add(users);
          });
        }

      // print(jsonData.amount);
    } else {
      print(Status.failedTxt);
    }
  }

  static void viewOne(String userId) async {
    Uri viewSingleUser =
        Uri.parse(API.listOfSendMoney.toString() + '/' + userId);
    final response = await http.get(viewSingleUser, headers: API.headers);

    if (response.statusCode == Status.ok) {
    } else {
      print(Status.failedTxt);
    }
  }
}
