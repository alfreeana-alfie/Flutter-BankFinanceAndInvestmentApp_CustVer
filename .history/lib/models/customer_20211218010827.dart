class Customer {
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

  Customer(
      {required this.id,
      required this.name,
      required this.minimumAmount,
      required this.maximumAmount,
      required this.interestRate,
      required this.duration,
      required this.durationType,
      required this.status,
      required this.description});

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
        id: map[Field.id] as int,
        name: map[Field.name] as String,
        minimumAmount: map[Field.minimumAmount] as String,
        maximumAmount: map[Field.maximumAmount] as String,
        interestRate: map[Field.interestRate] as String,
        duration: map[Field.duration] as int,
        durationType: map[Field.durationType] as String,
        status: map[Field.status] as int,
        description: map[Field.description] as String);
  }
}
