import 'package:flutter_banking_app/utils/string.dart';

class Currency {
  int?  id;
  String? status, baseCurrency,name, exchangeRate;

  Currency(
      {this.id,
      this.name,
      this.exchangeRate,
      this.baseCurrency,
      this.status});

  factory Currency.fromMap(Map<String, dynamic> map) {
    return Currency(
      id: map[Field.id] as int?,
      name: map[Field.name] as String?,
      exchangeRate: map[Field.exchangeRate] as String?,
      baseCurrency: map[Field.baseCurrency] as String?,
      status: map[Field.status] as String?,
    );
  }
}
