import 'package:flutter_banking_app/utils/string.dart';

class Currency {
  int id, bas;
  String name, exchangeRate, baseCurrency, status;

  Currency(
      {required this.id,
      required this.name,
      required this.exchangeRate,
      required this.baseCurrency,
      required this.status});

  factory Currency.fromMap(Map<String, dynamic> map) {
    return Currency(
      id: map[Field.id] as int,
      name: map[Field.name] as String,
      exchangeRate: map[Field.exchangeRate] as String,
      baseCurrency: map[Field.baseCurrency] as String,
      status: map[Field.status] as String,
    );
  }
}
