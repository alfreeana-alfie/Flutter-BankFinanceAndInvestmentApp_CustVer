import 'package:flutter_banking_app/utils/string.dart';

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
    this.totalPayable,
    this.totalPaid,
    this.latePaymentPenalty,
    this.attachment, 
    this.description,
    this.remarks, 
    this.status,
    this.approvedDate, 
    this.approvedUserId,
    this.createdUserId, 
    this.branchId
  });

  factory Loan.fromMap(Map<String, dynamic> map) {
    return Loan(
      id: map[Field.data][Field.id] as int?,
      loanId: map[Field.data][Field.loanId] as String,
      loanProductId: map[Field.data][Field.loanProductId] as String,
      borrowerId: map[Field.data][Field.borrowerId] as String,
      firstPaymentDate: map[Field.data][Field.firstPaymentDate] as String,
      releaseDate: map[Field.data][Field.releaseDate] as String,
      currencyId : map[Field.data][Field.currencyId] as String,
      appliedAmount: map[Field.data][Field.appliedAmount] as String,
      totalPayable: map[Field.data][Field.totalPayable] as String,
      totalPaid: map[Field.data][Field.totalPaid] as String,
      latePaymentPenalty: map[Field.data][Field.latePaymentPenalty] as String,
      attachment: map[Field.data][Field.attachment] as String,
      description: map[Field.data][Field.description] as String,
      remarks: map[Field.data][Field.remarks] as String,
      status: map[Field.data][Field.status] as String,
      approvedDate: map[Field.data][Field.approvedDate] as String,
      approvedUserId: map[Field.data]['approved_user_id'] as String,
      createdUserId: map[Field.data]['created_user_id'] as String,
      branchId: map[Field.data]['branch_id'] as String,
    );
  }
}
