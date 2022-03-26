import 'package:flutter_banking_app/utils/string.dart';

class Membership {
  int? id;
  String? position;
  String? planName,
      planFee,
      membershipTime,
      monthlyFixIncome,
      paymentRequestForm,
      membershipPlanStatus,
      monthlyFixIncomeStatus,
      annualMembershipFee,
      investment,
      investmentStatus,
      investmentDuration,
      // position,
      createdAt;

  Membership(
      {this.id,
      this.planName,
      this.planFee,
      this.membershipTime,
      this.monthlyFixIncome,
      this.paymentRequestForm,
      this.membershipPlanStatus,
      this.monthlyFixIncomeStatus,
      this.annualMembershipFee,
      this.investment,
      this.investmentStatus,
      this.investmentDuration,
      this.position,
      this.createdAt});

  factory Membership.fromMap(Map<String, dynamic> map) {
    return Membership(
      id: map[Field.id] as int?,
      planName: map[Field.planName] as String?,
      planFee: map[Field.planFee] as String?,
      membershipTime: map[Field.membershipTime] as String?,
      monthlyFixIncome: map[Field.monthlyFixIncome] as String?,
      paymentRequestForm: map[Field.paymentRequestForm] as String?,
      membershipPlanStatus: map[Field.membershipPlanStatus] as String?,
      monthlyFixIncomeStatus: map[Field.monthlyFixIncomeStatus] as String?,
      annualMembershipFee: map[Field.annualMembershipFee] as String?,
      investment: map[Field.investment] as String?,
      investmentDuration: map[Field.investmentDuration] as String?,
      investmentStatus: map[Field.investmentStatus] as String?,
      position: map[Field.position] as String?,
      createdAt: map[Field.createdAt] as String?,
    );
  }
}
