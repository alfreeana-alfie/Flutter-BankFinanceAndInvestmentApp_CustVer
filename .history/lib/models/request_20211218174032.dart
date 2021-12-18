import 'package:flutter_banking_app/utils/string.dart';

class Request {
  int? id;
  String? currencyId,
      amount,
      status,
      description,
      senderId,
      receiverId,
      transactionId,
      branchId;

  Request(
      {this.id,
      this.currencyId,
      this.amount,
      this.status,
      this.description,
      this.senderId,
      this.receiverId,
      this.transactionId,
      this.branchId});

  factory Request.fromMap(Map<String, dynamic> map) {
    return Request(
      id: map[Field.data][Field.id] as int,
      currencyId: map[Field.data][Field.currencyId] as String,
      amount: map[Field.data][Field.amount] as String,
      status: map[Field.data][Field.status] as String,
      description: map[Field.data][Field.description] as String,
      senderId: map[Field.data][Field.senderId] as String,
      receiverId: map[Field.data][Field.receiverId] as String,
      transactionId: map[Field.data][Field.transactionId] as String,
      note: map[Field.data][Field.note] as String,
      loanId: map[Field.data][Field.loanId] as String,
      refId: map[Field.data][Field.refId] as String,
      parentId: map[Field.data][Field.parentId] as String,
      otherBankId: map[Field.data][Field.otherBankId] as String,
      gatewayId: map[Field.data][Field.gatewayId] as String,
      createdUserId: map[Field.data][Field.createdUserId] as String,
      updatedUserId: map[Field.data][Field.updatedUserId] as String,
      branchId: map[Field.data][Field.branchId] as String,
      transactionsDetails: map[Field.data][Field.transactionsDetails] as String,
    );
  }
}
