import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_banking_app/pages/admin/branches/branch_layout.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/list.dart';
import 'package:oktoast/oktoast.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SharedPref {
  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  saveLogged(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return jsonDecode(prefs.getString(key) ?? '');
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}

class CustomToast {
  static showMsg(String text, Color color) {
    showToast(
      text,
      // duration: const Duration(seconds: 5),
      backgroundColor: color,
      position: ToastPosition.bottom,
      textPadding: const EdgeInsets.fromLTRB(60, 10, 60, 10),
      radius: 60,
    );
  }
}

class SMSNigeriaAPI {
  static void send(BuildContext context, String to, String body) async {
    var apiToken =
        'apYsrAtoGSjgkicEXuDyXDaIZfFQXjl3gQZ5AYVilVuqZq7TkWT6hSPfsaXD';
    var from = '2349021113979';

    Uri url = Uri.parse(smsApi.toString() +
        '?api_token=$apiToken&from=$from&to=$to&body=$body');

    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == Status.created) {
      CustomToast.showMsg(Status.success, Styles.successColor);
    } else {
      print(response.body);
      CustomToast.showMsg(Status.failed, Styles.dangerColor);
    }
  }
}

class EmailJS {
  static void send(
      BuildContext context,
      String toEmail,
      String toName,
      String fromName,
      String userMessage,
      String userMessage01,
      String userMessage02,
      String userMessage03) async {
    var serviceId = 'service_xsly86j';
    var templateId = 'template_6cmmlbk';
    var userId = 'user_eKHAYrEKc8tQPCDXxJzut';

    Uri url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_subject': 'FVIS Investment',
          'to_email': toEmail,
          'user_email': 'fvisng@gmail.com',
          'to_name': toName,
          'from_name': fromName,
          'user_message': userMessage,
          'user_message01': userMessage01,
          'user_message02': userMessage02,
          'user_message03': userMessage03,
        }
      }),
    );

    if (response.statusCode == Status.created) {
      CustomToast.showMsg(Status.success, Styles.successColor);
    } else {
      print(response.body);
      CustomToast.showMsg(Status.failed, Styles.dangerColor);
    }
  }

  static void verifyEmail(BuildContext context, String toName, String toEmail,
      String verificationLink) async {
    var serviceId = 'service_xsly86j';
    var templateId = 'template_ilga98i';
    var userId = 'user_eKHAYrEKc8tQPCDXxJzut';

    Uri url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          // 'to_name': toName,
          'to_email': toEmail,
          'verification_link': verificationLink,
        }
      }),
    );

    if (response.statusCode == Status.created) {
      CustomToast.showMsg(Status.success, Styles.successColor);
    } else {
      print(response.body);
      CustomToast.showMsg(Status.failed, Styles.dangerColor);
    }
  }

  static void welcomeMessage(
      BuildContext context,
      // String toName,
      String toEmail,
      // String verificationLink,
      String membershipId,
      String accountNo) async {
    var serviceId = 'service_xsly86j';
    var templateId = 'template_bdu1mff';
    var userId = 'user_eKHAYrEKc8tQPCDXxJzut';

    Uri url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          // 'to_name': toName,
          'to_email': toEmail,
          'membership_id': membershipId,
          'account_no': accountNo,
          // 'verification_link': verificationLink,
        }
      }),
    );

    if (response.statusCode == Status.created) {
      CustomToast.showMsg(Status.success, Styles.successColor);
    } else {
      print(response.body);
      CustomToast.showMsg(Status.failed, Styles.dangerColor);
    }
  }
}

class Method {
  static void addFile(
      BuildContext context,
      RoundedLoadingButtonController controller,
      Map<String, String> body,
      String filename,
      Uri url,
      String type,
      Widget routePath,
      String pageName,
      String image, String userType) async {
    final request = http.MultipartRequest(Field.postMethod, url)
      ..fields.addAll(body)
      ..headers.addAll(headersMultiPart)
      ..files.add(await http.MultipartFile.fromPath(image, filename));

    var response = await request.send();

    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);

    if (response.statusCode == Status.created) {
      // print(Status.success);

      CustomToast.showMsg(Status.success, Styles.successColor);
      Future.delayed(const Duration(milliseconds: 1500), () {
        controller.stop();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CardList(
              userType: userType,
              type: type,
              routePath: RouteSTR.createBranch,
              path: routePath,
              pageName: pageName,
            ),
          ),
        );
      });
    } else {
      // print(response.body);
      CustomToast.showMsg(Status.failed, Styles.dangerColor);
    }
  }

  //** ADD FUNCTION
  static void add(
      BuildContext context,
      RoundedLoadingButtonController controller,
      Map<String, String> body,
      Uri url,
      String type,
      Widget routePath,
      String pageName, String userType) async {
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == Status.created) {
      if (type != Type.nullable) {
        Future.delayed(const Duration(milliseconds: 1500), () {
          controller.stop();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CardList(
                userType: userType,
                type: type,
                routePath: RouteSTR.createBranch,
                path: routePath,
                pageName: pageName,
              ),
            ),
          );
        });
      }
    } else {
      print(response.body);
      CustomToast.showMsg(Status.failed, Styles.dangerColor);
    }
  }

  static void addWithdraw(
      BuildContext context,
      RoundedLoadingButtonController controller,
      Map<String, String> body,
      Uri url,
      String type,
      Widget routePath,
      String pageName, String userType) async {
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == Status.created) {
      if (type != Type.nullable) {
        Future.delayed(const Duration(milliseconds: 1500), () {
          controller.stop();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CardList(
                userType: userType,
                type: type,
                routePath: RouteSTR.createBranch,
                path: routePath,
                pageName: pageName,
              ),
            ),
          );
        });
      }
    } else {
      print(response.body);
      CustomToast.showMsg(Status.failed, Styles.dangerColor);
    }
  }

  // ** EDIT FUNCTION
  static void edit(
      BuildContext context,
      RoundedLoadingButtonController controller,
      Map<String, String> body,
      Uri url,
      String type,
      Widget path,
      String pageName,
      String routePath, String userType) async {
    final response = await http.put(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == Status.ok) {
      // CustomToast.showMsg(Status.success, Styles.successColor);
      if (type != Type.nullable) {
        Future.delayed(const Duration(milliseconds: 1500), () {
          controller.stop();
          // Navigator.pushReplacementNamed(context, routePath);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CardList(
                userType: userType,
                type: type,
                routePath: routePath,
                path: path,
                pageName: pageName,
              ),
            ),
          );
        });
      }
    } else {
      // print(Status.failed);
      CustomToast.showMsg(Status.failed, Styles.dangerColor);
    }
  }

  // ** DELETE FUNCTION
  static void delete(
      BuildContext context,
      // RoundedLoadingButtonController controller,
      // Map<String, String> body,
      Uri url,
      String type,
      Widget path,
      String pageName,
      String routePath, String userType) async {
    final response = await http.delete(url, headers: headers);

    if (response.statusCode == Status.ok) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CardList(
              userType: userType,
              type: type,
              routePath: routePath,
              path: path,
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

const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
const _numbers = '1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

String getRandomCode(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _numbers.codeUnitAt(_rnd.nextInt(_numbers.length))));
