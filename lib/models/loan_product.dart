import 'package:flutter_banking_app/utils/string.dart';

class LoanProduct {
  int id, term, status;
  String name,
      minAmt,
      maxAmt,
      description,
      interestType,
      interestRate,
      termPeriod,
      createdAt;

  LoanProduct(
      {required this.id,
      required this.name,
      required this.minAmt,
      required this.maxAmt,
      required this.description,
      required this.interestRate,
      required this.interestType,
      required this.term,
      required this.termPeriod,
      required this.status,
      required this.createdAt});

  factory LoanProduct.fromMap(Map<String, dynamic> map) {
    return LoanProduct(
      id: map[Field.id] as int,
      name: map[Field.name] as String,
      minAmt: map[Field.minimumAmount] as String,
      maxAmt: map[Field.maximumAmount] as String,
      description: map[Field.description] as String,
      interestRate: map[Field.interestRate] as String,
      interestType: map[Field.interestType] as String,
      term: map[Field.term] as int,
      termPeriod: map[Field.termPeriod] as String,
      status: map[Field.status] as int,
      createdAt: map[Field.createdAt] as String,
    );
  }
}
