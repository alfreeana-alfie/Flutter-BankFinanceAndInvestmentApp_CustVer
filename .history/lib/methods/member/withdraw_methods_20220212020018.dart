
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/list.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_banking_app/utils/api.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class WithdrawMethods {
  static void add(BuildContext context, Map<String, String> body) async {
    final response = await http.post(
      API.createWithdraw,
      headers: headers,
      body: body,
    );

    if (response.statusCode == Status.created) {
      // print(Status.success);
      CustomToast.showMsg(Status.success, Styles.successColor);
      Future.delayed(const Duration(milliseconds: 2000), () {

        Navigator.pushReplacementNamed(context, RouteSTR.withdrawListM);

      });
    } else {
      print(response.body);
      CustomToast.showMsg(Status.failed, Styles.dangerColor);
    }
  }

  static void update(BuildContext context, RoundedLoadingButtonController controller, Map<String, String> body, String type, String addRoute, String pageName) async {
    final response = await http.post(
      AdminAPI.updateWithdraw,
      headers: headers,
      body: body,
    );

    if (response.statusCode == Status.ok) {
      // print(Status.success);
      CustomToast.showMsg(Status.success, Styles.successColor);
      Future.delayed(const Duration(milliseconds: 1500), () {
          controller.stop();
          // Navigator.pushReplacementNamed(context, routePath);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CardList(
                type: type,
                routePath: addRoute,
                pageName: pageName,
              ),
            ),
          );
        });
    } else {
      print(response.body);
      CustomToast.showMsg(Status.failed, Styles.dangerColor);
    }
  }
}
