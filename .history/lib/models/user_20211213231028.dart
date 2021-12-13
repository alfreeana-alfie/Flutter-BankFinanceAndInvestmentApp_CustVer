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
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        phone = json['phone'],
        roleType = json['role_type'],
        roleId = json['role_id'],
        branchId = json['branch_id'],
        status = json['status'],
        profilePicture = json['profilePicture'],
        emailVerifiedAt = json['email_verified_at'],
        smsVerifiedAt = json['sms_verified_at'],
        provider = json['provider'],
        providerId = json['provider_id'],
        countryCode = json['country_code'];

  Map<String, dynamic> toJson() => {
        Field.id: id,
        'name': name,
        'email': email,
        'phone': phone,
        'role_type': roleType,
        'role_id': roleId,
        'branch_id': branchId,
        'status': status,
        'profile_picture': profilePicture,
        'email_verified_at': emailVerifiedAt,
        'sms_verified_at': smsVerifiedAt,
        'provider': provider,
        'provider_id': providerId,
        'country_code': countryCode,
      };
}
