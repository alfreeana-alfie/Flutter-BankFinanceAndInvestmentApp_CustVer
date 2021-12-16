class PlanFDR {
  int? id, duration, status;
  String? name,
      minimumAmount,
      maximumAmount,
      interestRate,
      durationType,
      description;
  
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
      baseCurrency: map[Field.baseCurrency] as int,
      status: map[Field.status] as int,
    );
  }
}
