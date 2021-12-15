class Currency {
  int id;
  String name,
      exchangeRate,
      baseCurrency,
      status;

  Currencyt(
      {required this.id,
      required this.userId,
      required this.currencyId,
      required this.amount,
      required this.fee,
      required this.drCr,
      required this.type,
      required this.method,
      required this.status,
      required this.note, 
      required this.loanId,
      required this.refId, 
      required this.parentId,
      required this.otherBankId,
      required this.gatewayId,
      required this.createdUserId,
      required this.updatedUserId,
      required this.branchId,
      required this.transactionsDetails});

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map[Field.data][Field.id] as int,
      userId: map[Field.data][Field.userId] as String,
      currencyId: map[Field.data][Field.currencyId] as String,
      amount: map[Field.data][Field.amount] as String,
      fee: map[Field.data][Field.fee] as String,
      drCr: map[Field.data][Field.drCr] as String,
      type: map[Field.data][Field.type] as String,
      method: map[Field.data][Field.method] as String,
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
