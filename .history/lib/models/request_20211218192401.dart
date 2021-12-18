import 'package:flutter_banking_app/utils/string.dart';

class Request {
  String? currencyName,
      amount,
      status,
      description,
      senderId,
      receiverId,
      transactionId,
      branchId, 
      createdAt;

  Request(
      {
      this.currencyName,
      this.amount,
      this.status,
      this.description,
      this.senderId,
      this.receiverId,
      this.transactionId,
      this.branchId,
      this.createdAt});

  factory Request.fromMap(Map<String, dynamic> map) {
    return Request(
      currencyName: map[Field.data][Field.currencyName] as String,
      amount: map[Field.data][Field.amount] as String,
      status: map[Field.data][Field.status] as String,
      description: map[Field.data][Field.description] as String,
      senderId: map[Field.data][Field.senderId] as String,
      receiverId: map[Field.data][Field.receiverId] as String,
      transactionId: map[Field.data][Field.transactionId] as String,
      branchId: map[Field.data][Field.branchId] as String,
      createdAt: map[Field.data][Field.createdAt] as String,
    );
  }
}
