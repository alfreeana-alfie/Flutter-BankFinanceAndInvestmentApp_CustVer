class Loan {
  int? id;
  String? loanId,
      loanProductId,
      borrowerId,
      firstPaymentDate,
      releaseDate,
      currencyId,
      appliedAmount,
      totalPayable,
      totalPaid,
      latePaymentPenalty,
      attachment,
      description,
      remarks,
      status,
      approvedDate,
      approvedUserId,
      createdUserId,
      branchId;
  
  Loan({
    this.id, 
    this.loanId,
    this.loanProductId,
    this.borrowerId,
    this.firstPaymentDate,
    this.releaseDate,
    this.currencyId,
    this.appliedAmount,
    this.matureDate,
    this.transactionId,
    this.attachment, 
    this.remarks, 
    this.status,
    this.approvedDate, 
    this.approvedUserId,
    this.createdUserId, 
    this.updatedUserId,
    this.branchId
  });

  factory Loan.fromMap(Map<String, dynamic> map) {
    return Loan(
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
      branchId: map['data']['branch_id'] as String,
    );
  }
}
