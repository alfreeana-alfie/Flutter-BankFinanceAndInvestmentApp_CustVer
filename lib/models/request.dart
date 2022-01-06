import 'package:flutter_banking_app/utils/string.dart';

class PaymentRequest {
  String? senderId, status, transactionId, branchId;
  String? currencyName,
      amount,
      description,
      senderName,
      receiverName,
      createdAt;

  PaymentRequest(
      {this.currencyName,
      this.amount,
      this.status,
      this.description,
      this.senderId,
      this.senderName,
      this.receiverName,
      this.transactionId,
      this.branchId,
      this.createdAt});

  factory PaymentRequest.fromMap(Map<String, dynamic> map) {
    return PaymentRequest(
        currencyName: map[Field.currencyName] as String?,
        amount: map[Field.amount] as String?,
        status: map[Field.status] as String?,
        description: map[Field.description] as String?,
        senderId: map[Field.senderId] as String?,
        senderName: map[Field.senderName] as String?,
        receiverName: map[Field.receiverName] as String?,
        transactionId: map[Field.transactionId] as String?,
        branchId: map[Field.branchId] as String?,
        createdAt: map[Field.createdAt] as String?);
  }
}
