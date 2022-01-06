import 'package:flutter_banking_app/utils/string.dart';

class GiftCard {
  int? id;
  String? name, code, amount, usedAt,userId, branchId, status, currencyId;

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
      currencyId: map[Field.currencyId] as String?,
      status: map[Field.status] as String?,
      userId: map[Field.userId] as String?,
      branchId: map[Field.branchId] as String?,
      usedAt: map[Field.usedAt] as String?
    );
  }
}
