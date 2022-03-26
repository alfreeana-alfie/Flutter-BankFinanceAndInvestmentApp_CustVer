import 'package:flutter_banking_app/utils/string.dart';

class Token {
  String? token, expiredAt;

  Token(this.token, this.expiredAt);

  Token.fromJSON(Map<String, dynamic> json)
      : token     = json[Pref.accessToken],
        expiredAt = json[Pref.expiredAt];
}

class MessageAPI {
  String? message;

  MessageAPI(this.message);

  MessageAPI.fromJSON(Map<String, dynamic> json) : message = json[Pref.message];
}
