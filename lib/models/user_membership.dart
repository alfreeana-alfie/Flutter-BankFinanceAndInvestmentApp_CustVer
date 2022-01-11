import 'package:flutter_banking_app/utils/string.dart';

class UserMembership {
  int? id;
  String? status;
  String? userName, userEmail, userPhone, planName, planFee, transactionCode, membershipPlanId;

  UserMembership();
  
  // UserMembership(
  //     {this.id,
  //     this.userName,
  //     this.userEmail,
  //     this.userPhone,
  //     this.planName,
  //     this.planFee,
  //     this.status,
  //     this.transactionCode});

  // factory UserMembership.fromMap(Map<String, dynamic> map) {
  //   return UserMembership(
  //     id: map[Field.id] as int?,
  //     userName: map[Field.name] as String?,
  //     userEmail: map[Field.email] as String?,
  //     userPhone: map[Field.phone] as String?,
  //     planName: map[Field.planName] as String?,
  //     planFee: map[Field.planFee] as String?,
  //     status: map[Field.status] as String?,
  //     transactionCode: map[Field.transactionCode] as String?,
  //   );
  // }

  UserMembership.fromJSON(Map<String, dynamic> json)
      : id = json[Field.id],
        userName = json[Field.name],
        userEmail = json[Field.email],
        userPhone = json[Field.phone],
        planName = json[Field.planName],
        planFee = json[Field.planFee],
        status = json[Field.status],
        transactionCode = json[Field.transactionCode],
        membershipPlanId = json[Field.membershipPlanId]
        ;

  Map<String, dynamic> toJson() => {
        Field.id: id,
        Field.name: userName,
        Field.email: userEmail,
        Field.phone: userPhone,
        Field.planName: planName,
        Field.planFee: planFee,
        Field.status: status,
        Field.transactionCode: transactionCode,
        Field.membershipPlanId: membershipPlanId
      };
}
