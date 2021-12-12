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
      smsVerifiedAt,
      provider,
      providerId,
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
      this.smsVerifiedAt,
      this.provider,
      this.providerId,
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
        smsVerifiedAt = json['smsVerifiedAt'],
        provider = json['provider'],
        providerId = json['providerId'],
        country_code = json['country_code'];
}
