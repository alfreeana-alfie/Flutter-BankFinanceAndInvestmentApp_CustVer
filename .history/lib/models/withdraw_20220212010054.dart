import 'package:flutter_banking_app/utils/string.dart';

class Withdraw {
  int? id;
  String? name,
      bankName,
      branchName,
      swiftCode,
      accountHolderName,
      accountNo,
      accountHolderPhoneNo,
      currency,
      amount,
      approved,
      createdAt;

  Withdraw(
      {this.id,
      this.name,
      this.bankName,
      this.branchName,
      this.swiftCode,
      this.accountHolderName,
      this.accountNo,
      this.accountHolderPhoneNo,
      this.currency,
      this.amount,
      this.approved,
      this.createdAt});

  factory Withdraw.fromMap(Map<String, dynamic> map) {
    return Withdraw(
      id: map[Field.id] as int?,
      name: map[Field.userId] as String?,
      bankName: map[Field.accountId] as String?,
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
