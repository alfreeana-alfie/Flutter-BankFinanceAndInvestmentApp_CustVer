import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_banking_app/utils/api.dart';

class LoanRequestMethods {
  static void add(
      BuildContext context, Map<String, String> body, String filename) async {
    final request = http.MultipartRequest(Field.postMethod, API.loanRequest)
      ..fields.addAll(body)
      ..headers.addAll(headersMultiPart)
      ..files.add(await http.MultipartFile.fromPath(
          Field.attachment, filename));
      
      final request1 = http.MultipartRequest(Field.postMethod, API.loanRequest)
      ..fields.addAll(body)
      ..headers.addAll(headersMultiPart)
      ..files.addAll({
        await http.MultipartFile.fromPath(Field.attachment, filename),
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
