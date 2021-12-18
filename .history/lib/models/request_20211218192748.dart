import 'package:flutter_banking_app/utils/string.dart';

class Request {
  String? currencyName,
      amount,
      status,
      description,
      senderName,
      receiverName,
      transactionId,
      branchId, 
      createdAt;

  Request(
      {
      this.currencyName,
      this.amount,
      this.status,
      this.description,
      this.senderName,
      this.receiverName,
      this.transactionId,
      this.branchId,
      this.createdAt});

  factory Request.fromMap(Map<String, dynamic> map) {
    return Request(
      currencyName: [Field.currencyName] as String?,
      amount: [Field.amount] as String?,
      status: [Field.status] as String?,
      description: [Field.description] as String?,
      senderName: [Field.senderName] as String?,
      receiverName: [Field.receiverName] as String?,
      transactionId: [Field.transactionId] as String,
      branchId: [Field.branchId] as String,
      createdAt: [Field.createdAt] as String,
    );
  }
}
