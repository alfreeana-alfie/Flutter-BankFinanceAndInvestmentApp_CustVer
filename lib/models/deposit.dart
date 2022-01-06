import 'package:flutter_banking_app/utils/string.dart';

class Deposit {
  int? id, status;
  String? userName, name, amount, fee, drCr, type, method, note;

  Deposit(
      {required this.id,
        required this.userName,
      required this.name,
      required this.amount,
      required this.fee,
      required this.drCr,
      required this.type,
      required this.method,
      required this.status,
      required this.note});

  factory Deposit.fromMap(Map<String, dynamic> map) {
    return Deposit(
      id: map[Field.id] as int?,
      userName: map[Field.userName] as String?,
      name: map[Field.name] as String?,
      amount: map[Field.amount] as String?,
      fee: map[Field.fee] as String?,
      drCr: map[Field.drCr] as String?,
      type: map[Field.type] as String?,
      method: map[Field.method] as String?,
      status: map[Field.status] as int?,
      note: map[Field.note] as String?,
    );
  }
}
