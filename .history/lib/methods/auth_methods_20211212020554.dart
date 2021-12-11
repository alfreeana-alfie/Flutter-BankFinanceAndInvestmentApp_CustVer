import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_banking_app/constant/api.dart';
import 'package:flutter_banking_app/models/token.dart';
import 'package:flutter_banking_app/utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void signIn(String email, String password, BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();

  Map<String, dynamic> tokenMap;

  final response = await http.post(
    API.loginUrl,
    headers: API.headers,
    body: {'email': email, 'password': password},
  );

  if (response.statusCode == 200) {
    tokenMap = jsonDecode(response.body);

    var verifyData = Token.fromJSON(tokenMap);
    print(verifyData.token);
    if (verifyData.token.isNotEmpty) {
    } else {
      print(Str.);
    }
  }
}
