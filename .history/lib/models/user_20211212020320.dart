class User {
  String? id,
      name,
      email,
      phone,
      role_type,
      role_id,
      branch_id,
      status,
      profile_pictre,
      email_verified_at,
      sms_verified_at,
      provider,
      provider_id,
      country_code;

  User(
      this.id,
      this.name,
      this.email,
      this.phone,
      this.role_type,
      this.role_id,
      this.branch_id,
      this.status,
      this.profile_pictre,
      this.email_verified_at,
      this.sms_verified_at,
      this.provider,
      this.provider_id,
      this.country_code);

  User.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        id = json['name'],
        id = json['email'],
        id = json['phone'],
        id = json['role_type'],
        id = json['role_id'],
        id = json['branch_id'],
        status = json['status'],
        profile_picture = json['profile_picture'],
        email_verified_at = json['email_verified_at'],
        sms_verified_at = json['sms_verified_at'],
        provider = json['provider'],
        provider_id = json['provider_id'],
        country_code = json['country_code'];
}
