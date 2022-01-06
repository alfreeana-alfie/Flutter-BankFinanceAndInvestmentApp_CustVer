import 'package:flutter_banking_app/utils/string.dart';

class PlanFDR {
  int? id;
  String? name,
      minimumAmount,
      maximumAmount,
      interestRate,
      durationType,
      description, duration, status;
  
  PlanFDR(
      {this.id,
      this.name,
      this.minimumAmount,
      this.maximumAmount,
      this.interestRate,
      this.duration,
      this.durationType,
      this.status,
      this.description});

  factory PlanFDR.fromMap(Map<String, dynamic> map) {
    return PlanFDR(
      id: map[Field.id] as int?,
      name: map[Field.name] as String?,
      minimumAmount: map[Field.minimumAmount] as String?,
      maximumAmount: map[Field.maximumAmount] as String?,
      interestRate: map[Field.interestRate] as String?,
      duration: map[Field.duration] as String?,
      durationType: map[Field.durationType] as String?,
      status: map[Field.status] as String?
    );
  }
}
