import 'package:flutter_banking_app/utils/string.dart';

class Branch {
  int? id;
  String? name, contactEmail, contactPhone, address, descriptions;

  Branch(
      { this.id,
       this.name,
       this.contactEmail,
       this.contactPhone,
       this.address, 
       this.descriptions});

  factory Branch.fromMap(Map<String, dynamic> map) {
    return Branch(
      id: map[Field.id] as int?,
      name: map[Field.name] as String?,
      contactEmail: map[Field.contactEmail] as String?,
      contactPhone: map[Field.contactPhone] as String?,
      address: map[Field.address] as String?,
      descriptions: map[Field.descriptions] as String?,
    );
  }
}
