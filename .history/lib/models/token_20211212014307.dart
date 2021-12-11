class Token {
  String token;

  Token(this.token);

  Token.fromJSON(Map<String, dynamic> json)
      : token = json['token'];
}
