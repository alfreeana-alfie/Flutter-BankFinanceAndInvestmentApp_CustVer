import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/models/token.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void signIn(BuildContext context, Map<String, String> body) async {
  final response = await http.post(
    API.login,
    headers: API.headers,
    body: body,
  );

  if (response.statusCode == 200) {
    var jsonBody = Token.fromJSON(jsonDecode(response.body));
    String accessToken = jsonBody.token;

    final prefs = await SharedPreferences.getInstance();
    prefs.setString(Pref.accessToken, accessToken);

    getUserDetails();
  } else {
    print(AuthSTR.failedAuthTxt);
  }
}

void getUserDetails() async {
  final prefs = await SharedPreferences.getInstance();
  String? accessToken = prefs.getString(Pref.accessToken);

  final response = await http.get(API.getUserDetails, 
  headers: {
    'Content-Type': 'application/json',
    'Accept'      : 'application/json',
    'Authorization': 'Bearer $accessToken',
  });

  if (response.statusCode == 200) {
    var jsonBody = User.fromJSON(jsonDecode(response.body));
    String? name = jsonBody.name;

    print('Welcome, $name');
  } else {
    print(ApiSTR.failedTxt);
  }
}

void signOut() async {
  final prefs = await SharedPreferences.getInstance();
  String? accessToken = prefs.getString(Pref.accessToken);

  final response = await http.get(API.logout, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $accessToken',
  });

  if (response.statusCode == 200) {
    var jsonBody = MessageAPI.fromJSON(jsonDecode(response.body));
    String? message = jsonBody.message;

    print(message);
    prefs.clear();
  } else {
    print(ApiSTR.failedTxt);
  }
}
