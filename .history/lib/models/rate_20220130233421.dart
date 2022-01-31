import 'package:flutter_banking_app/utils/string.dart';

class Rate {
  int?  id;
  String? functionName, currentRate;

  Rate(
      {this.id,
      this.functionName,
      this.currentRate});

  factory Rate.fromMap(Map<String, dynamic> map) {
    return Rate(
      id: map[Field.id] as int?,
      functionName: map[Field.functionName] as String?,
      exchangeRate: map[Field.exchangeRate] as String?,
      baseRate: map[Field.baseRate] as String?,
      status: map[Field.status] as String?,
    );
  }
}
