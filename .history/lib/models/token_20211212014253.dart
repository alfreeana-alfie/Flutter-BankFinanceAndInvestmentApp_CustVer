class Token {
  String token;

  Token(this.token);

  Token.fromJSON(Map<String, dynamic> json)
      : id        = json['data']['uid'],;
}
