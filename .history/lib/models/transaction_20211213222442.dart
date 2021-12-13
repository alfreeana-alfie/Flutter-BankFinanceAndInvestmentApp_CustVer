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
      fee: map['data']['fee'] as String,
      drCr: map['data']['dr_cr'] as String,
      type: map['data']['type'] as String,
      method: map['data']['method'] as String,
      status: map['data']['status'] as String,
      note: map['data']['note'] as String,
      loanId: map['data']['loan_id'] as String,
      refId: map['data']['ref_id'] as String,
      parentId: map['data']['parent_id'] as String,
      otherBankId: map['data']['other_bank_id'] as String,
      gatewayId: map['data']['gateway_id'] as String,
      createdUserId: map['data']['created_user_id'] as String,
      updatedUserId: map['data']['updated_user_id'] as String,
      branchId: map['data']['branch_id'] as String,
      
    );
  }
}
