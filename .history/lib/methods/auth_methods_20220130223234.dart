import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/models/token.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:http/http.dart' as http;
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'config.dart';

SharedPref sharedPref = SharedPref();

void signIn(BuildContext context, Map<String, String> body,
    RoundedLoadingButtonController controller) async {
  final response = await http.post(
    API.login,
    headers: headers,
    body: body,
  );

  if (response.statusCode == Status.ok) {
    var jsonBody = Token.fromJSON(jsonDecode(response.body));

    sharedPref.save(Pref.accessToken, jsonBody.token);
    sharedPref.save(Pref.expiredAt, jsonBody.expiredAt);

    controller.stop();

    getUserDetails(context);
  } else {
    controller.stop();
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

    if (jsonBody.userType == Field.customerTxt) {
      Navigator.pushNamed(context, RouteSTR.dashboardMember);
    } else {
      Navigator.pushNamed(context, RouteSTR.dashboardAdmin);
    }
  } else {
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

    sharedPref.remove(Pref.accessToken);
    sharedPref.remove(Pref.expiredAt);
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

void signUp(BuildContext context, Map<String, String> body) async {
  final response = await http.post(
    API.signUp,
    headers: headers,
    body: body,
  );

  if (response.statusCode == Status.created) {
    CustomToast.showMsg(Status.successTxt, Styles.successColor);
    Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.pushReplacementNamed(context, RouteSTR.signIn);
    });
  } else {
    print(response.body);
    // print(Status.failedTxt);
    CustomToast.showMsg(Status.failedTxt, Styles.dangerColor);
  }
}

void updateSMS(BuildContext context, Map<String, String> body, String id) async {
    Uri url =
        Uri.parse(API.updateWallet.toString() + id);

    final response = await http.put(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == Status.ok) {
      CustomToast.showMsg(Status.successTxt, Styles.successColor);
      
    } else {
      print(response.body);
      // print(Status.failedTxt);
      CustomToast.showMsg(Status.failedTxt, Styles.dangerColor);
    }
  }
