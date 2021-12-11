class Token {
  String token;

  Token(this.token);

  User.fromJSON(Map<String, dynamic> json)
      : id        = json['data']['uid'],
        name      = json['data']['name'],
        username  = json['data']['username'],
        email     = json['data']['email'],
        image     = json['data']['image'];

}
