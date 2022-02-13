import 'package:flutter_banking_app/utils/string.dart';

class WalletTransaction {
  int? id;
  String? userId, userName, walletId, accountId, method, creditDebit, amount, rateAmount, grandTotal, paymentMethod,  createdAt, updatedBy;

  WalletTransaction(
      {this.id,
      this.userName,
      this.userId,
      this.accountId,
      this.walletId,
      this.creditDebit,
      this.method,
      this.amount,
      this.rateAmount,
      this.grandTotal,
      this.paymentMethod,
      this.createdAt, 
      this.updatedBy});

  factory WalletTransaction.fromMap(Map<String, dynamic> map) {
    return WalletTransaction(
      id: map[Field.id] as int?,
      userName: map[Field.name] as String?,
      userId: map[Field.userId] as String?,
      accountId: map[Field.accountId] as String?,
      walletId: map[Field.walletId] as String?,
      method: map[Field.method] as String?,
      creditDebit: map[Field.creditDebit] as String?,
      amount: map[Field.amount] as String?,
      rateAmount: map[Field.rateAmount] as String?,
      grandTotal: map[Field.grandTotal] as String?,
      paymentMethod: map[Field.paymentMethod] as String?,
      createdAt: map[Field.createdAt] as String?,
      updatedBy: map[Field.updatedBy] as String?,
    );
  }
}
