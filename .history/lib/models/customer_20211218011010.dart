import 'package:flutter_banking_app/utils/string.dart';

class Customer {
  int? id, status, roleId;
  String? name,
      email,
      phone,
      userType,
      roleType,
      branchId,
      profilePicture,
      emailVerifiedAt,
      smsVerifiedAt,
      provider,
      providerId,
      countryCode;

  Customer(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.userType,
      this.roleType,
      this.branchId,
      this.profilePicture,
      this.emailVerifiedAt,
      this.smsVerifiedAt,
      this.provider,
      this.providerId,
      this.countryCode});

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
        id: map[Field.id] as int,
        name: map[Field.name] as String,
        minimumAmount: map[Field.minimumAmount] as String,
        maximumAmount: map[Field.maximumAmount] as String,
        interestRate: map[Field.interestRate] as String,
        duration: map[Field.duration] as int,
        durationType: map[Field.durationType] as String,
        status: map[Field.status] as int,
        description: map[Field.description] as String);
  }
}
