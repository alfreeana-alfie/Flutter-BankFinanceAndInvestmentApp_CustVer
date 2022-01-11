import 'dart:convert';

import 'package:http/http.dart' as http;

createAccessCode(skTest, amount, userEmail) async {
  // skTest -> Secret key
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $skTest'
  };
  Map data = {'amount': int.parse(amount) * 100, 'email': userEmail};
  String payload = json.encode(data);
  http.Response response = await http.post(
      Uri.parse('https://api.paystack.co/transaction/initialize'),
      headers: headers,
      body: payload);
  return jsonDecode(response.body);
}