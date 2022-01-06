import 'package:flutter_banking_app/utils/string.dart';

class Transaction {
  int? userId,
      status,
      currencyId,
      loanId,
      refId,
      parentId,
      otherBankId,
      gatewayId,
      createdUserId,
      updatedUserId,
      branchId,
      id;
  String? amount, fee, drCr, type, method, note, transactionsDetails, createdAt;

  Transaction(
      {this.id,
      this.userId,
      this.currencyId,
      this.amount,
      this.fee,
      this.drCr,
      this.type,
      this.method,
      this.status,
      this.note,
      this.loanId,
      this.refId,
      this.parentId,
      this.otherBankId,
      this.gatewayId,
      this.createdUserId,
      this.updatedUserId,
      this.branchId,
      this.transactionsDetails,
      this.createdAt});

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map[Field.id] as int?,
      userId: map[Field.userId] as int?,
      currencyId: map[Field.currencyId] as int?,
      amount: map[Field.amount] as String?,
      fee: map[Field.fee] as String?,
      drCr: map[Field.drCr] as String?,
      type: map[Field.type] as String?,
      method: map[Field.method] as String?,
      status: map[Field.status] as int?,
      note: map[Field.note] as String?,
      loanId: map[Field.loanId] as int?,
      refId: map[Field.refId] as int?,
      parentId: map[Field.parentId] as int?,
      otherBankId: map[Field.otherBankId] as int?,
      gatewayId: map[Field.gatewayId] as int?,
      createdUserId: map[Field.createdUserId] as int?,
      updatedUserId: map[Field.updatedUserId] as int?,
      branchId: map[Field.branchId] as int?,
      transactionsDetails: map[Field.transactionsDetails] as String?,
      createdAt: map[Field.createdAt] as String?,
    );
  }
}
