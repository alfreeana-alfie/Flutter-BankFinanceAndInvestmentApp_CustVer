import 'package:flutter_banking_app/utils/string.dart';

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
      id: map[Field.data][Field.id] as int?,
      fdrPlanId: map[Field.data][Field.fdrPlanId] as String,
      userId: map[Field.data][Field.userId] as String,
      currencyId : map[Field.data][Field.currencyId] as String,
      depositAmount: map[Field.data][Field.depositAmount] as String,
      returnAmount: map[Field.data][Field.returnAmount] as String,
      attachment: map[Field.data][Field.attachment] as String,
      remarks: map[Field.data][Field.remarks] as String,
      status: map[Field.data][Field.status] as String,
      approvedDate: map[Field.data][Field.approvedDate] as String,
      matureDate: map[Field.data][Field.matureDate] as String,
      transactionId: map[Field.data][Field.transactionId] as String,
      approvedUserId: map[Field.data][Field.approvedUserId] as String,
      createdUserId: map[Field.data][Field.createdUserId] as String,
      updatedUserId: map[Field.data][Field.updatedUserId] as String,
      branchId: map[Field.data]['branch_id'] as String,
    );
  }
}
