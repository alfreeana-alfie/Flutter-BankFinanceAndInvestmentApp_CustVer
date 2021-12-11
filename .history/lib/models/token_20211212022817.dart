class Token {
  String token;

  Token(this.token);

  Token.fromJSON(Map<String, dynamic> json) : token = json['access_token'];
}

class MessageAPI {
  String token;

  MessageAPI(this.token);

  MessageAPI.fromJSON(Map<String, dynamic> json) : token = json['access_token'];
}
