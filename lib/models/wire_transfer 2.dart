import 'package:flutter_banking_app/utils/string.dart';

class Transfer {
  String? userName, name, amount, fee, drCr, type, method, note;
  String? status;

  Transfer(
      {this.userName,
      this.name,
      this.amount,
      this.fee,
      this.drCr,
      this.type,
      this.method,
      this.status,
      this.note});

  factory Transfer.fromMap(Map<String, dynamic> map) {
    return Transfer(
      userName: map[Field.userName] as String?,
      name: map[Field.name] as String?,
      amount: map[Field.amount] as String?,
      fee: map[Field.fee] as String?,
      drCr: map[Field.drCr] as String?,
      type: map[Field.type] as String?,
      method: map[Field.method] as String?,
      status: map[Field.status] as String?,
      note: map[Field.note] as String?,
    );
  }
}
