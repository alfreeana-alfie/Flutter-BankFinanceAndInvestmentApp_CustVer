class Transaction {
  int? id;
  String? userId,
      currencyId,
      amount,
      fee,
      drCr,
      type,
      method,
      status,
      note,
      loanId,
      refId,
      parentId,
      otherBankId,
      gatewayId,
      createdUserId,
      updatedUserId,
      branchId,
      transactionsDetails;

  Transaction({this.id, this.userId, this.currencyId, this.amount, this.fee, });

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['data']['id'] as int?, 

    );
  }
}
