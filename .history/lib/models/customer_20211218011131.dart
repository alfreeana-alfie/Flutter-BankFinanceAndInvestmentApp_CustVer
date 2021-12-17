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
      this.roleId,
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
        email: map[Field.email] as String,
        phone: map[Field.phone] as String,
        userType: map[Field.userType] as String,
        roleId: map[Field.roleId] as int,
        roleType: map[Field.roleType] as String,
        branchId: map[Field.branchId] as String,
        profilePicture: map[Field.profilePicture] as int,
        description: map[Field.description] as String);
  }
}
