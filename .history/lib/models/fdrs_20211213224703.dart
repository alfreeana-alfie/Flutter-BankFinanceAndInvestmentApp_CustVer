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
      fdrPlanId: map['data']['fdr_plan_id'] as String,
      userId: map['data']['user_id'] as String,
      currencyId : map['data']['currency_id'] as String,
      depositAmount: map['data']['deposit_amount'] as String,
      returnAmount: map['data']['return_amount'] as String,
      attachment: map['data']['attachment'] as String,
      remarks: map['data']['remarks'] as String,
      status: map['data']['status'] as String,
      approvedDate: map['data']['approved_date'] as String,
      matureDate: map['data']['mature_date'] as String,
      transactionId: map['data']['transaction_id'] as String,
      approvedUserId: map['data']['approved_user_id'] as String,
      createdUserId: map['data']['created_user_id'] as String,
      updatedUserId: map['data']['updated_user_id'] as String,
      createdUserId: map['data']['created_user_id'] as String,
      updatedUserId: map['data']['updated_user_id'] as String,
      branchId: map['data']['branch_id'] as String,
      transactionsDetails: map['data']['transactions_details'] as String,
    );
  }
}
