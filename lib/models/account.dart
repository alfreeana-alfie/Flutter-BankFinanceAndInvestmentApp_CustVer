import 'package:flutter_banking_app/utils/string.dart';

class Account {
  int? id;
  String? accountName, description;

  Account(
      {this.id,
      this.accountName,
      this.description});

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map[Field.id] as int?,
      accountName: map[Field.accountName] as String?,
      description: map[Field.description] as String?,
    );
  }
}
