import 'package:flutter_banking_app/utils/string.dart';

class Currency {
  int id;
  String name, exchangeRate, baseCurrency, status;

  Currency(
      {required this.id,
      required this.name,
      required this.exchangeRate,
      required this.baseCurrency,
      required this.status});

  factory Currency.fromMap(Map<String, dynamic> map) {
    return Currency(
      id: map[Field.data][Field.id] as int,
      name: map[Field.data][Field.name] as String,
      exchangeRate: map[Field.data][Field.exchangeRate] as String,
      baseCurrency: map[Field.data][Field.baseCurrency] as String,
      status: map[Field.data][Field.status] as String,
    );
  }
}
