import 'package:flutter_banking_app/utils/string.dart';

class Wallet {
  int? id;
  String? userId, accountId, amount, description;

  Wallet(
      {this.id,
      this.userId,
      this.accountId,
      this.amount, 
      this.description});

  factory Wallet.fromMap(Map<String, dynamic> map) {
    return Wallet(
      id: map[Field.id] as int?,
      userId: map[Field.userId] as String?,
      accountId: map[Field.accountId] as String?,
      description: map[Field.description] as String?,
      amount: map[Field.amount] as String?,
    );
  }

  waLL.fromJSON(Map<String, dynamic> json)
      : id = json[Field.id],
        name = json[Field.name],
        email = json[Field.email],
        phone = json[Field.phone],
        roleType = json[Field.roleType],
        userType = json[Field.userType],
        roleId = json[Field.roleId],
        branchId = json[Field.branchId],
        status = json[Field.status],
        profilePicture = json[Field.profilePicture],
        emailVerifiedAt = json[Field.emailVerified],
        smsVerifiedAt = json[Field.smsVerified],
        provider = json[Field.provider],
        providerId = json[Field.providerId],
        countryCode = json[Field.countryCode];
}
