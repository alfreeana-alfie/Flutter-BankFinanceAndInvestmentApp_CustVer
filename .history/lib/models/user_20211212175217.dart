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
      countryCode;

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
      this.countryCode);

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
        emailVerifiedAt = json['email_verifiedAt'],
        smsVerifiedAt = json['smsVerifiedAt'],
        provider = json['provider'],
        providerId = json['providerId'],
        countryCode = json['countryCode'];
}
