import 'package:flutter_banking_app/utils/string.dart';

class Transaction {
  int? userId,status,id;
  String? 
      currencyId,
      amount,
      fee,
      drCr,
      type,
      method,
      
      note,
      loanId,
      refId,
      parentId,
      otherBankId,
      gatewayId,
      createdUserId,
      updatedUserId,
      branchId,
      transactionsDetails,
      createdAt;

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
      currencyId: map[Field.currencyId] as String?,
      amount: map[Field.amount] as String?,
      fee: map[Field.fee] as String?,
      drCr: map[Field.drCr] as String?,
      type: map[Field.type] as String?,
      method: map[Field.method] as String?,
      status: map[Field.status] as int?,
      note: map[Field.note] as String?,
      loanId: map[Field.loanId] as String?,
      refId: map[Field.refId] as String?,
      parentId: map[Field.parentId] as String?,
      otherBankId: map[Field.otherBankId] as String?,
      gatewayId: map[Field.gatewayId] as String?,
      createdUserId: map[Field.createdUserId] as String?,
      updatedUserId: map[Field.updatedUserId] as String?,
      branchId: map[Field.branchId] as String?,
      transactionsDetails: map[Field.transactionsDetails] as String?,
      createdAt: map[Field.createdAt] as String?,
    );
  }
}
