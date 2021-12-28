import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/models/token.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:http/http.dart' as http;

import 'config.dart';

SharedPref sharedPref = SharedPref();

void signIn(BuildContext context, Map<String, String> body) async {
  final response = await http.post(
    API.login,
    headers: headers,
    body: body,
  );

  if (response.statusCode == Status.ok) {
    var jsonBody = Token.fromJSON(jsonDecode(response.body));

    sharedPref.save(Pref.accessToken, jsonBody.token);
    sharedPref.saveLogged(Pref.isLoggedIn, true);

    getUserDetails(context);
  } else {
    // print(AuthSTR.failedAuthTxt);
    CustomToast.showMsg(Status.failedTxt, Styles.dangerColor);
  }
}

void getUserDetails(BuildContext context) async {
  String? accessToken = await sharedPref.read(Pref.accessToken);

  final response = await http.get(API.getUserDetails, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $accessToken',
  });

  if (response.statusCode == Status.ok) {
    var jsonBody = User.fromJSON(jsonDecode(response.body));

    sharedPref.save(Pref.userData, jsonBody);

    print(response.body);

    print(jsonBody.userType);

    if (jsonBody.userType == Field.customerTxt) {
      Navigator.pushNamed(context, RouteSTR.dashboardMember);
    } else {
      Navigator.pushNamed(context, RouteSTR.dashboardAdmin);
    }
  } else {
    // print(Status.failedTxt);
    CustomToast.showMsg(Status.failedTxt, Styles.dangerColor);
  }
}

void signOut(BuildContext context) async {
  String? accessToken = await sharedPref.read(Pref.accessToken);

  final response = await http.get(API.logout, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $accessToken',
  });

  if (response.statusCode == Status.created) {
    // var jsonBody = MessageAPI.fromJSON(jsonDecode(response.body));
    // String? message = jsonBody.message;

    // print(message);
    sharedPref.remove(Pref.accessToken);
    sharedPref.remove(Pref.userData);

    if (response.statusCode == Status.ok) {
      Navigator.pushNamed(context, RouteSTR.dashboardMember);
    } else {
      // print(Status.failedTxt);
      CustomToast.showMsg(Status.failedTxt, Styles.dangerColor);
    }
  } else {
    // print(Status.failedTxt);
    CustomToast.showMsg(Status.failedTxt, Styles.dangerColor);
  }
}
