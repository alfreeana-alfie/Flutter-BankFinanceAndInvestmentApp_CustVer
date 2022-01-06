import 'package:flutter_banking_app/utils/string.dart';

class GiftCard {
  int? id,userId, branchId, status, currencyId;
  String? name, code, amount, usedAt;

  GiftCard(
      {this.id, 
        this.name,
      this.code,
      this.amount,
      this.currencyId,
      this.status,
      this.userId,
      this.branchId, 
      this.usedAt});

  factory GiftCard.fromMap(Map<String, dynamic> map) {
    return GiftCard(
      id: map[Field.id] as int?,
      name: map[Field.name] as String?,
      code: map[Field.code] as String?,
      amount: map[Field.amount] as String?,
      currencyId: map[Field.currencyId] as int?,
      status: map[Field.status] as int?,
      userId: map[Field.userId] as int?,
      branchId: map[Field.branchId] as int?,
      usedAt: map[Field.usedAt] as String?
    );
  }
}
