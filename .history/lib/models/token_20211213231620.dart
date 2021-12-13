class Token {
  String token;

  Token(this.token);

  Token.fromJSON(Map<String, dynamic> json) : token = json[Pref.];
}

class MessageAPI {
  String? message;

  MessageAPI(this.message);

  MessageAPI.fromJSON(Map<String, dynamic> json) : message = json['message'];
}
