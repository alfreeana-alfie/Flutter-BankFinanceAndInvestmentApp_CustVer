import 'package:flutter_banking_app/utils/string.dart';

class Users {
  int? status, roleId;
  String? id,
      name,
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
      countryCode,
      createdAt;

  Users(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.userType,
      this.roleId,
      this.roleType,
      this.branchId,
      this.status,
      this.profilePicture,
      this.emailVerifiedAt,
      this.smsVerifiedAt,
      this.provider,
      this.providerId,
      this.countryCode,
      this.createdAt});

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      id: map[Field.id] as String,
      name: map[Field.name] as String,
      email: map[Field.email] as String,
      phone: map[Field.phone] as String,
      userType: map[Field.userType] as String,
      roleId: map[Field.roleId] as int,
      roleType: map[Field.roleType] as String,
      branchId: map[Field.branchId] as String,
      status: map[Field.status] as int,
      profilePicture: map[Field.profilePicture] as String,
      emailVerifiedAt: map[Field.emailVerified] as String,
      smsVerifiedAt: map[Field.smsVerified] as String,
      provider: map[Field.provider] as String,
      providerId: map[Field.providerId] as String,
      countryCode: map[Field.countryCode] as String,
      createdAt: map[Field.createdAt] as String,
    );
  }
}
