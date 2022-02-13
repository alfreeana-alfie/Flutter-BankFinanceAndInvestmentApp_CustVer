import 'package:flutter_banking_app/utils/string.dart';

class User {
  int? id;
  String? roleId,
      status,
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
      welcomeMessage,
      accountNo,
      memberId;

  User();

  User.fromJSON(Map<String, dynamic> json)
      : id = json[Field.id],
        name = json[Field.name],
        email = json[Field.email],
        phone = json[Field.phone],
        roleType = json[Field.roleType],
        userType = json[Field.userType],
        roleId = json[Field.roleId],
        branchId = json[Field.branchId],
        status = json[Field.status],
        profilePicture = json[Field.profilePicture],
        emailVerifiedAt = json[Field.emailVerified],
        smsVerifiedAt = json[Field.smsVerified],
        provider = json[Field.provider],
        providerId = json[Field.providerId],
        countryCode = json[Field.countryCode],
        welcomeMessage = json[Field.welcome],
        accountNo = json[Field.accountNo],
        memberId = json[Field.memberId];

  Map<String, dynamic> toJson() => {
        Field.id: id,
        Field.name: name,
        Field.email: email,
        Field.phone: phone,
        Field.userType: userType,
        Field.roleType: roleType,
        Field.roleId: roleId,
        Field.branchId: branchId,
        Field.status: status,
        Field.profilePicture: profilePicture,
        Field.emailVerified: emailVerifiedAt,
        Field.smsVerified: smsVerifiedAt,
        Field.provider: provider,
        Field.providerId: providerId,
        Field.countryCode: countryCode,
        Field.welcome: welcomeMessage,
        Field.accountNo: accountNo,
        Field.memberId: 
      };
}
