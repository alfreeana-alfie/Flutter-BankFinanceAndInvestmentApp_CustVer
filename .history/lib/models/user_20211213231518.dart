import 'package:flutter_banking_app/utils/string.dart';

class User {
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

  User();

  User.fromJSON(Map<String, dynamic> json)
      : id = json[Field.id],
        name = json[Field.name],
        email = json[Field.email],
        phone = json[Field.phone],
        roleType = json[Field.roleType],
        roleId = json[Field.roleId],
        branchId = json[Field.branchId],
        status = json[Field.status],
        profilePicture = json[Field.profilePicture],
        emailVerifiedAt = json[Field.emailVerified],
        smsVerifiedAt = json[Field.smsVerified],
        provider = json['provider'],
        providerId = json['provider_id'],
        countryCode = json['country_code'];

  Map<String, dynamic> toJson() => {
        Field.id: id,
        Field.name: name,
        Field.email: email,
        Field.phone: phone,
        Field.roleType: roleType,
        Field.roleId: roleId,
        Field.branchId: branchId,
        Field.status: status,
        Field.profilePicture: profilePicture,
        Field.emailVerified: emailVerifiedAt,
        Field.smsVerified: smsVerifiedAt,
        'provider': provider,
        'provider_id': providerId,
        'country_code': countryCode,
      };
}
