import 'package:flutter_banking_app/utils/string.dart';

class FixedDeposit {
  int? status,
      fdrPlanId,
      transactionId,
      approvedUserId,
      createdUserId,
      updatedUserId,
      branchId,
      userId;
  String? depositAmount,
      returnAmount,
      attachment,
      remarks,
      approvedDate,
      matureDate,
      createdAt;

  FixedDeposit(
      {this.fdrPlanId,
      this.userId,
      // this.currencyId,
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
      this.branchId,
      this.createdAt});

  factory FixedDeposit.fromMap(Map<String, dynamic> map) {
    return FixedDeposit(
      fdrPlanId: map[Field.fdrPlanId] as int?,
      userId: map[Field.userId] as int?,
      // currencyId : map[Field.currencyId] as String,
      depositAmount: map[Field.depositAmount] as String?,
      returnAmount: map[Field.returnAmount] as String?,
      attachment: map[Field.attachment] as String?,
      remarks: map[Field.remarks] as String?,
      status: map[Field.status] as int?,
      approvedDate: map[Field.approvedDate] as String?,
      matureDate: map[Field.matureDate] as String?,
      transactionId: map[Field.transactionId] as int?,
      approvedUserId: map[Field.approvedUserId] as int?,
      createdUserId: map[Field.createdUserId] as int?,
      updatedUserId: map[Field.updatedUserId] as int?,
      branchId: map[Field.branchId] as int?,
      createdAt: map[Field.createdAt] as String?,
    );
  }
}
