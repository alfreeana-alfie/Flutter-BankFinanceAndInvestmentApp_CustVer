import 'package:flutter_banking_app/utils/string.dart';

class PaymentRequest {
  int? 
      senderId,status, 
      transactionId, branchId;
  String? currencyName, amount,
      description,
      senderName,
      receiverName;
  
  DateTime? createdAt;

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
  status: map[Field.status] as int?,
  description: map[Field.description] as String?,
  senderId: map[Field.senderId] as int?,
  senderName: map[Field.senderName] as String?,
  receiverName: map[Field.receiverName] as String?,
  transactionId: map[Field.transactionId] as int?,
  branchId: map[Field.branchId] as int?,
  createdAt: map[Field.createdAt] as DateTime?
    );
  }
}
