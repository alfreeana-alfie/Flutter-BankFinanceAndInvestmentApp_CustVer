import 'package:flutter_banking_app/utils/string.dart';

class Loan {
  int?  id;
  String? borrowerId, approvedUserId, createdUserId, branchId, status,loanId,
      loanProductId,
      firstPaymentDate,
      releaseDate,
      currencyId,
      appliedAmount,
      totalPayable,
      totalPaid,
      latePaymentPenalty,
      attachment,
      nationalIdentityCard,
      bankStatement,
      description,
      remarks,
      approvedDate,
      createdAt,
      transactionCode;

  Loan(
      {this.id,
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
      this.branchId,
      this.createdAt,
      this.transactionCode});

  factory Loan.fromMap(Map<String, dynamic> map) {
    return Loan(
      // id: map[Field.id] as int?,
      loanId: map[Field.loanId] as String?,
      borrowerId: map[Field.borrowerId] as String?,
      firstPaymentDate: map[Field.firstPaymentDate] as String?,
      releaseDate: map[Field.releaseDate] as String?,
      appliedAmount: map[Field.appliedAmount] as String?,
      totalPayable: map[Field.totalPayable] as String?,
      totalPaid: map[Field.totalPaid] as String?,
      latePaymentPenalty: map[Field.latePaymentPenalty] as String?,
      attachment: map[Field.attachment] as String?,
      description: map[Field.description] as String?,
      remarks: map[Field.remarks] as String?,
      status: map[Field.status] as String?,
      approvedUserId: map[Field.approvedUserId] as String?,
      createdUserId: map[Field.createdUserId] as String?,
      branchId: map[Field.branchId] as String?,
      createdAt: map[Field.createdAt] as String?,
      transactionCode: map[Field.transactionCode] as String?,
    );
  }
}
