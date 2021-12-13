import 'package:flutter/material.dart';


void sendMoney() async {
  void signIn(BuildContext context, Map<String, String> body) async {
  final response = await http.post(
    API.login,
    headers: API.headers,
    body: body,
  );

  if (response.statusCode == 200) {
    var jsonBody = Token.fromJSON(jsonDecode(response.body));

    sharedPref.save(Pref.accessToken, jsonBody.token);
    sharedPref.saveLogged(Pref.isLoggedIn, true);

    getUserDetails(context);
  } else {
    print(AuthSTR.failedAuthTxt);
  }
}
}