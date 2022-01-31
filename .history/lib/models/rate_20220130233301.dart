import 'package:flutter_banking_app/utils/string.dart';

class Rate {
  int?  id;
  String? status, baseRate,name, exchangeRate;

  Rate(
      {this.id,
      this.name,
      this.exchangeRate,
      this.baseRate,
      this.status});

  factory Rate.fromMap(Map<String, dynamic> map) {
    return Rate(
      id: map[Field.id] as int?,
      name: map[Field.name] as String?,
      exchangeRate: map[Field.exchangeRate] as String?,
      baseRate: map[Field.baseRate] as String?,
      status: map[Field.status] as String?,
    );
  }
}
