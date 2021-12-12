class User {
  int? id, status;
  String? name,
      email,
      phone,
      userType,
      roleType,
      roleId,
      branchId,
      profilePicture,
      emailVerifiedAt,
      sms_verified_at,
      provider,
      provider_id,
      country_code;

  User(
      this.id,
      this.name,
      this.email,
      this.phone,
      this.roleType,
      this.roleId,
      this.branchId,
      this.status,
      this.profilePicture,
      this.emailVerifiedAt,
      this.sms_verified_at,
      this.provider,
      this.provider_id,
      this.country_code);

  User.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        phone = json['phone'],
        roleType = json['roleType'],
        roleId = json['roleId'],
        branchId = json['branchId'],
        status = json['status'],
        profilePicture = json['profilePicture'],
        emailVerifiedAt = json['emailVerifiedAt'],
        sms_verified_at = json['sms_verified_at'],
        provider = json['provider'],
        provider_id = json['provider_id'],
        country_code = json['country_code'];
}
