import 'package:flutter_banking_app/utils/string.dart';

class Currency {
  int id;
  String name,
      exchangeRate,
      baseCurrency,
      status;

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
      note: map[Field.data][Field.note] as String,
      loanId: map[Field.data][Field.loanId] as String,
      refId: map[Field.data][Field.refId] as String,
      parentId: map[Field.data][Field.parentId] as String,
      otherBankId: map[Field.data][Field.otherBankId] as String,
      gatewayId: map[Field.data][Field.gatewayId] as String,
      createdUserId: map[Field.data][Field.createdUserId] as String,
      updatedUserId: map[Field.data][Field.updatedUserId] as String,
      branchId: map[Field.data][Field.branchId] as String,
      transactionsDetails: map[Field.data][Field.transactionsDetails] as String,
    );
  }
}
