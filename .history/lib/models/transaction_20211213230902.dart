import 'package:flutter_banking_app/utils/string.dart';

class Transaction {
  int? id;
  String? userId,
      currencyId,
      amount,
      fee,
      drCr,
      type,
      method,
      status,
      note,
      loanId,
      refId,
      parentId,
      otherBankId,
      gatewayId,
      createdUserId,
      updatedUserId,
      branchId,
      transactionsDetails;

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
      this.transactionsDetails});

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map[Field.data][Field.id] as int?,
      userId: map[Field.data][Field.userId] as String,
      currencyId: map[Field.data][Field.currencyId] as String,
      amount: map[Field.data][Field.amount] as String,
      fee: map[Field.data][Field.fee] as String,
      drCr: map[Field.data][Field.drCr] as String,
      type: map[Field.data][Field.type] as String,
      method: map[Field.data][Field.method] as String,
      status: map[Field.data][Field.status] as String,
      note: map[Field.data][Field.note] as String,
      loanId: map[Field.data][Field.loanId] as String,
      refId: map[Field.data][Field.refId] as String,
      parentId: map[Field.data]['parent_id'] as String,
      otherBankId: map[Field.data]['other_bank_id'] as String,
      gatewayId: map[Field.data]['gateway_id'] as String,
      createdUserId: map[Field.data]['created_user_id'] as String,
      updatedUserId: map[Field.data]['updated_user_id'] as String,
      branchId: map[Field.data]['branch_id'] as String,
      transactionsDetails: map[Field.data]['transactions_details'] as String,
    );
  }
}
