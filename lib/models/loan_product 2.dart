import 'package:flutter_banking_app/utils/string.dart';

class LoanProduct {
  int? id;
  String? name,
      minAmt,
      maxAmt,
      description,
      interestType,
      interestRate,
      termPeriod,
      createdAt, term, status;

  LoanProduct(
      {this.id,
      this.name,
      this.minAmt,
      this.maxAmt,
      this.description,
      this.interestRate,
      this.interestType,
      this.term,
      this.termPeriod,
      this.status,
      this.createdAt});

  factory LoanProduct.fromMap(Map<String, dynamic> map) {
    return LoanProduct(
      id: map[Field.id] as int?,
      name: map[Field.name] as String?,
      minAmt: map[Field.minimumAmount] as String?,
      maxAmt: map[Field.maximumAmount] as String?,
      description: map[Field.description] as String?,
      interestRate: map[Field.interestRate] as String?,
      interestType: map[Field.interestType] as String?,
      term: map[Field.term] as String?,
      termPeriod: map[Field.termPeriod] as String?,
      status: map[Field.status] as String?,
      createdAt: map[Field.createdAt] as String?,
    );
  }
}
