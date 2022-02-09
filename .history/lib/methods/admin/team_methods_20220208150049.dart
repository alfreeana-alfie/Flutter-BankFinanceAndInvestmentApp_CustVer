import 'package:flutter/material.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:http/http.dart' as http;

import '../config.dart';

class TeamMethods {
  static void add(
      BuildContext context, Map<String, String> body, String filename) async {
    // final response = await http.post(
    //   API.loanRequest,
    //   headers: headers,
    //   body: body,
    // );
    final request = http.MultipartRequest(Field.postMethod, AdminAPI.createTeam)
      ..fields.addAll(body)
      ..headers.addAll(headersMultiPart)
      ..files.add(await http.MultipartFile.fromPath(
          Field.image, filename));

    var response = await request.send();

    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);

    if (response.statusCode == Status.created) {
      // print(Status.success);
      
      CustomToast.showMsg(Status.success, Styles.successColor);
      Future.delayed(const Duration(milliseconds: 2000), () {
        Navigator.pushReplacementNamed(context, RouteSTR.teamList);
      });
    } else {
      // print(response.body);

      CustomToast.showMsg(Status.failed, Styles.dangerColor);
    }
  }

  static void edit(BuildContext context, Map<String, String> body, String id) async {
    Uri url =
        Uri.parse(AdminAPI.updateTeam.toString() + id);

    final response = await http.put(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == Status.ok) {
      // print(Status.success);
      CustomToast.showMsg(Status.success, Styles.successColor);
      Future.delayed(const Duration(milliseconds: 2000), () {

        Navigator.pushReplacementNamed(context, RouteSTR.teamList);

      });
    } else {
      print(Status.failed);
      CustomToast.showMsg(Status.failed, Styles.dangerColor);
    }
  }

  static void delete(BuildContext context, String id) async {
    Uri url =
        Uri.parse(AdminAPI.deleteTeam.toString() + id);

    final response = await http.delete(
      url,
      headers: headers
    );

    if (response.statusCode == Status.ok) {
      CustomToast.showMsg(Status.success, Styles.successColor);
      // Future.delayed(const Duration(milliseconds: 2000), () {

      //   Navigator.pushReplacementNamed(context, RouteSTR.currencyList);

      // });
    } else {
      print(Status.failed);
      CustomToast.showMsg(Status.failed, Styles.dangerColor);
    }
  }
}