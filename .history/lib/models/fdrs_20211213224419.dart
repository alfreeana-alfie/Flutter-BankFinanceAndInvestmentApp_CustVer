class FDR {
  int? id;
  String? fdrPlanId,
      userId,
      currencyId,
      depositAmount,
      returnAmount,
      attachment,
      remarks,
      status,
      approvedDate,
      matureDate,
      transactionId,
      approvedUserId,
      createdUserId,
      updatedUserId,
      branchId;

  FDR({
    this.id, 
    this.fdrPlanId,
    this.userId,
    this.currencyId,
    this.depositAmount,
    this.returnAmount,
    this.attachment, 
    this.remarks, 
    this.status,
    this.approvedDate, 
    this.matureDate,
    this.transactionId,
    this.approvedUserId,
    this.createdUserId, 
    this.updatedUserId,
    this.branchId
  });

  factory FDR.fromMap(Map<String, dynamic> map) {
    return FDR(
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
      transactionsDetails: map['data']['transactions_details'] as String,
    );
  }
}
