import 'package:flutter_banking_app/utils/string.dart';

class PlanFDR {
  int? id, duration, status;
  String? name,
      minimumAmount,
      maximumAmount,
      interestRate,
      durationType,
      description;
  
  PlanFDR(
      {required this.id,
      required this.name,
      required this.minimumAmount,
      required this.maximumAmount,
      required this.interestRate,
      required this.duration,
      required this.durationType,
      required this.status,
      required this.description});

  factory PlanFDR.fromMap(Map<String, dynamic> map) {
    return PlanFDR(
      id: map[Field.id] as int,
      name: map[Field.name] as String,
      minimumAmount: map[Field.exchangeRate] as String,
      baseCurrency: map[Field.baseCurrency] as int,
      status: map[Field.status] as int,
    );
  }
}
