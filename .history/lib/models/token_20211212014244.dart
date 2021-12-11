class Token {
  String token;

  Token(this.token);

  Token.fromJSON(Map<String, dynamic> json)
      : id        = json['data']['uid'],
        name      = json['data']['name'],
        username  = json['data']['username'],
        email     = json['data']['email'],
        image     = json['data']['image'];
}
