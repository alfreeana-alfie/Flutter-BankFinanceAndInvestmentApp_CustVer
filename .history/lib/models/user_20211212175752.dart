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
        emailVerifiedAt = json['email_verified_at'],
        smsVerifiedAt = json['sms_verified_at'],
        provider = json['provider'],
        providerId = json['provider_id'],
        countryCode = json['country_code'];

  Map<String, dynamic> toJson() => {
        'id': id, 
        'name': name, 
        'email': email, 
        'phone': phone, 
        'role_type': roleType, 
        'role_id': roleId, 
        'branch_id': branchId, 
        'status': status, 
        'id': id, 
        'id': id, 
        'id': id, 
        'provider': provider, 
        'id': id, 
        'country_code': countryCode, 
  };
}
