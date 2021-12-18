import 'dart:convert';

import 'package:flutter_banking_app/utils/string.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    return json.decode(prefs.getString(key) ?? '');
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  showToast(
        Status.successTxt,
        backgroundColor: Styles.successColor,
        position: ToastPosition.bottom,
        textPadding: EdgeInsets.fromLTRB(40, 10, 40, 10),
        radius: 40,
      );
}
