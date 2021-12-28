import 'package:flutter_banking_app/utils/string.dart';

class GiftCard {
  int? userId, branchId, status;
  String? name, code, amount, usedAt;

  GiftCard(
      {this.name,
      this.code,
      this.amount,
      this.status,
      this.userId,
      this.branchId, 
      this.usedAt});

  factory GiftCard.fromMap(Map<String, dynamic> map) {
    return GiftCard(
      name: map[Field.name] as String?,
      code: map[Field.code] as String?,
      amount: map[Field.amount] as String?,
      status: map[Field.status] as int?,
      userId: map[Field.userId] as int?,
      branchId: map[Field.branchId] as int?,
      usedAt: map[Field.usedAt] as String?
    );
  }
}
