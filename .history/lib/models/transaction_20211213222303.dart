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

  Transaction(
      {this.id,
      this.userId,
      this.currencyId,
      this.amount,
      this.fee,
      this.drCr,
      this.type,
      this.method,
      this.status,
      this.note, 
      this.loanId,
      this.refId, 
      this.parentId,
      this.otherBankId,
      this.gatewayId,
      this.createdUserId,
      this.updatedUserId,
      this.branchId,
      this.transactionsDetails});

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['data']['id'] as int?,
      userId: map['data']['user_id'] as String,
      currencyId: map['data']['curreny_id'] as String,
      amount: map['data']['amount'] as String,
      
    );
  }
}
