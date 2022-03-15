import 'package:flutter_banking_app/utils/string.dart';

class Users {
  int? id;
  String? name,
      email,
      phone,
      userType,
      roleType,
      status,
      profilePicture,
      emailVerifiedAt,
      smsVerifiedAt,
      provider,
      providerId,
      countryCode,
      password,
      createdAt,
      roleId,
      branchId,
      accountNo,
      memberId, ;

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
      this.password,
      this.createdAt,
      this.accountNo,
      this.memberId});

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      id: map[Field.id] as int?,
      name: map[Field.name] as String?,
      email: map[Field.email] as String?,
      phone: map[Field.phone] as String?,
      userType: map[Field.userType] as String?,
      roleId: map[Field.roleId] as String?,
      roleType: map[Field.roleType] as String?,
      branchId: map[Field.branchId] as String?,
      status: map[Field.status] as String?,
      profilePicture: map[Field.profilePicture] as String?,
      emailVerifiedAt: map[Field.emailVerified] as String?,
      smsVerifiedAt: map[Field.smsVerified] as String?,
      provider: map[Field.provider] as String?,
      password: map[Field.password] as String?,
      providerId: map[Field.providerId] as String?,
      countryCode: map[Field.countryCode] as String?,
      createdAt: map[Field.createdAt] as String?,
      accountNo: map[Field.accountNo] as String?,
      memberId: map[Field.memberId] as String?,
    );
  }

  static List<Users> fromJsonList(List list) {
    return list.map((item) => Users.fromMap(item)).toList();
  }
}
