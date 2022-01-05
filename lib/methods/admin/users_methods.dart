import 'package:flutter/material.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:http/http.dart' as http;

import '../config.dart';

class UserMethods {
  static void add(BuildContext context, Map<String, String> body) async {
    final response = await http.post(
      AdminAPI.createUser,
      headers: headers,
      body: body,
    );

    if (response.statusCode == Status.created) {
      // print(Status.successTxt);
      CustomToast.showMsg(Status.successTxt, Styles.successColor);
      Navigator.pop(context);
    } else {
      // print(Status.failedTxt);
      CustomToast.showMsg(Status.failedTxt, Styles.dangerColor);
    }
  }

  static void addUserRole(BuildContext context, Map<String, String> body) async {
    final response = await http.post(
      AdminAPI.createUserRole,
      headers: headers,
      body: body,
    );

    if (response.statusCode == Status.created) {
      // print(Status.successTxt);
      CustomToast.showMsg(Status.successTxt, Styles.successColor);
      Navigator.pop(context);
    } else {
      // print(Status.failedTxt);
      CustomToast.showMsg(Status.failedTxt, Styles.dangerColor);
    }
  }

  static void addPermission(BuildContext context, Map<String, String> body) async {
    final response = await http.post(
      AdminAPI.createPermission,
      headers: headers,
      body: body,
    );

    if (response.statusCode == Status.created) {
      // print(Status.successTxt);
      CustomToast.showMsg(Status.successTxt, Styles.successColor);
      Navigator.pop(context);
    } else {
      // print(Status.failedTxt);
      CustomToast.showMsg(Status.failedTxt, Styles.dangerColor);
    }
  }

  static void editUserRole(BuildContext context, Map<String, String> body, String id) async {
    Uri url =
        Uri.parse(AdminAPI.updateUserRole.toString() + id);

    final response = await http.put(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == Status.ok) {
      // print(Status.successTxt);
      CustomToast.showMsg(Status.successTxt, Styles.successColor);
      Future.delayed(const Duration(milliseconds: 2000), () {

        Navigator.pushReplacementNamed(context, RouteSTR.userRoleList);

      });
    } else {
      // print(Status.failedTxt);
      CustomToast.showMsg(Status.failedTxt, Styles.dangerColor);
    }
  }

  static void editPermission(BuildContext context, Map<String, String> body, String id) async {
    Uri url =
        Uri.parse(AdminAPI.updatePermission.toString() + id);

    final response = await http.put(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == Status.ok) {
      // print(Status.successTxt);
      CustomToast.showMsg(Status.successTxt, Styles.successColor);
      Future.delayed(const Duration(milliseconds: 2000), () {

        Navigator.pushReplacementNamed(context, RouteSTR.permissionList);

      });
    } else {
      // print(Status.failedTxt);
      CustomToast.showMsg(Status.failedTxt, Styles.dangerColor);
    }
  }
}