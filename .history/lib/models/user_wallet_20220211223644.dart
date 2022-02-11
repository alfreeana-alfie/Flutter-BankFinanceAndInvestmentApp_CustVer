import 'package:flutter_banking_app/utils/string.dart';

class UserWallet {
  int? id;
  String? userName, userId,userPhone, accountId, amount, description;

  UserWallet(
      {this.id,
      this.userName,
      this.userId,
      this.accountId,
      this.amount, 
      this.description});

  factory UserWallet.fromMap(Map<String, dynamic> map) {
    return UserWallet(
      id: map[Field.id] as int?,
      userId: map[Field.userId] as String?,
      userName: map[Field.name] as String?,
      accountId: map[Field.accountId] as String?,
      description: map[Field.description] as String?,
      amount: map[Field.amount] as String?,
    );
  }

  UserWallet.fromJSON(Map<String, dynamic> json)
      : id = json[Field.id],
        userId = json[Field.userId],
        userName = json[Field.userName],
        accountId = json[Field.accountId],
        description = json[Field.description],
        amount = json[Field.amount];
}
