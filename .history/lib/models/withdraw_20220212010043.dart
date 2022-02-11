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
      bankName
branchName
swiftCode
accountHolderName
accountNo
accountHolderPhoneNo
currency
amount
approved
createdAt: map[Field.userId] as String?,
      bankName
branchName
swiftCode
accountHolderName
accountNo
accountHolderPhoneNo
currency
amount
approved
createdAt: map[Field.accountId] as String?,
      bankName
branchName
swiftCode
accountHolderName
accountNo
accountHolderPhoneNo
currency
amount
approved
createdAt: map[Field.walletId] as String?,
      bankName
branchName
swiftCode
accountHolderName
accountNo
accountHolderPhoneNo
currency
amount
approved
createdAt: map[Field.method] as String?,
      bankName
branchName
swiftCode
accountHolderName
accountNo
accountHolderPhoneNo
currency
amount
approved
createdAt: map[Field.creditDebit] as String?,
      bankName
branchName
swiftCode
accountHolderName
accountNo
accountHolderPhoneNo
currency
amount
approved
createdAt: map[Field.amount] as String?,
      bankName
branchName
swiftCode
accountHolderName
accountNo
accountHolderPhoneNo
currency
amount
approved
createdAt: map[Field.rateAmount] as String?,
      bankName
branchName
swiftCode
accountHolderName
accountNo
accountHolderPhoneNo
currency
amount
approved
createdAt: map[Field.grandTotal] as String?,
      bankName
branchName
swiftCode
accountHolderName
accountNo
accountHolderPhoneNo
currency
amount
approved
createdAt: map[Field.paymentMethod] as String?,
      bankName
branchName
swiftCode
accountHolderName
accountNo
accountHolderPhoneNo
currency
amount
approved
createdAt: map[Field.createdAt] as String?,
      bankName
branchName
swiftCode
accountHolderName
accountNo
accountHolderPhoneNo
currency
amount
approved
createdAt: map[Field.updatedBy] as String?,
    );
  }
}
