import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text(signInPageSuccess)));

        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => BottomNav()));
      } else {
        print('FAILED');
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text(incorrectEmailOrPassword)));
      }
    }
  }