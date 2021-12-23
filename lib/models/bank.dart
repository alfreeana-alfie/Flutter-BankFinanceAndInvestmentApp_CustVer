import 'package:flutter_banking_app/utils/string.dart';

class Bank {
  int? status,bankCurrency,id;
  String? name,
      swiftCode,
      bankCountry,
      minTransferAmt,
      maxTransferAmt,
      fixedCharge,
      chargeInPercentage,
      descriptions,
      
      createdAt;

  Bank(
      { this.id,
       this.name,
       this.swiftCode,
       this.bankCountry,
       this.bankCurrency, 
       this.minTransferAmt, 
       this.maxTransferAmt, 
       this.fixedCharge, 
       this.chargeInPercentage, 
       this.descriptions, 
       this.status, 
       this.createdAt});

  factory Bank.fromMap(Map<String, dynamic> map) {
    return Bank(
      id: map[Field.id] as int?,
      name: map[Field.name] as String?,
      swiftCode: map[Field.swiftCode] as String?,
      bankCountry: map[Field.bankCountry] as String?,
      bankCurrency: map[Field.bankCurrency] as int?,
      minTransferAmt: map[Field.minTransferAmt] as String?,
      maxTransferAmt: map[Field.maxTransferAmt] as String?,
      fixedCharge: map[Field.fixedCharge] as String?,
      chargeInPercentage: map[Field.chargeInPercentage] as String?,
      descriptions: map[Field.descriptions] as String?,
      status: map[Field.status] as int?,
      createdAt: map[Field.createdAt] as String?,
    );
  }
}
