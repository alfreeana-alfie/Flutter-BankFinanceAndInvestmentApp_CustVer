import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

void save(String key, value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key, json.encode(value));
}

void read(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return json.
}
