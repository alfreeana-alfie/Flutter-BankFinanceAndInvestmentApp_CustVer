import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_banking_app/utils/api.dart';

class LoanRequestMethods {
  static void add(BuildContext context, Map<String, String> body,
      String filename, String fileName02, String fileName03) async {
    // final request = http.MultipartRequest(Field.postMethod, API.loanRequest)
    //   ..fields.addAll(body)
    //   ..headers.addAll(headersMultiPart)
    //   ..files.add(await http.MultipartFile.fromPath(
    //       Field.attachment, filename));

    final request = http.MultipartRequest(Field.postMethod, API.loanRequest)
      ..fields.addAll(body)
      ..headers.addAll(headersMultiPart)
      ..files.addAll({
        await http.MultipartFile.fromPath(Field.attachment, filename),
        await http.MultipartFile.fromPath(
            Field.nationalIdentityCard, fileName02),
        await http.MultipartFile.fromPath(Field.bankStatement, fileName03)
      });

    var response = await request.send();

    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);

    if (response.statusCode == Status.created) {
      CustomToast.showMsg(Status.success, Styles.successColor);
      Future.delayed(const Duration(milliseconds: 2000), () {
        Navigator.pushReplacementNamed(context, RouteSTR.loanListM);
      });
    } else {
      // print(response.body);
      CustomToast.showMsg(Status.failed, Styles.dangerColor);
    }
  }

  static void addBytes(BuildContext context, Map<String, String> body,
      Uint8List? filename, Uint8List? fileName02, Uint8List? fileName03) async {
    List<int> listData = filename!.cast();
    List<int> listData02 = filename.cast();
    List<int> listData03 = filename.cast();

    final request = http.MultipartRequest(Field.postMethod, API.loanRequest)
      ..fields.addAll(body)
      ..headers.addAll(headersMultiPart)
      ..files.addAll({
        http.MultipartFile.fromBytes(Field.attachment, listData, filename: 'attachment.pdf'),
        http.MultipartFile.fromBytes(Field.nationalIdentityCard, listData02),
        http.MultipartFile.fromBytes(Field.bankStatement, listData03)
      });

    var response = await request.send();

    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);

    if (response.statusCode == Status.created) {
      CustomToast.showMsg(Status.success, Styles.successColor);
      Future.delayed(const Duration(milliseconds: 2000), () {
        Navigator.pushReplacementNamed(context, RouteSTR.loanListM);
      });
    } else {
      // print(response.body);
      CustomToast.showMsg(Status.failed, Styles.dangerColor);
    }
  }
}
