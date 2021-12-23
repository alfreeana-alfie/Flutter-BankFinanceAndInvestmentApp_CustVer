import 'package:flutter_banking_app/utils/string.dart';

class Bank {
  int? id;
  String? name,
      swiftCode,
      bankCountry,
      bankCurrency,
      minTransferAmt,
      maxTransferAmt,
      fixedCharge,
      chargeInPercentage,
      descriptions,
      status,
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
      bankCurrency: map[Field.bankCurrency] as String?,
      minTransferAmt: map[Field.minTransferAmt] as String?,
      maxTransferAmt: map[Field.maxTransferAmt] as String?,
      fixedCharge: map[Field.fixedCharge] as String?,
      chargeInPercentage: map[Field.chargeInPercentage] as String?,
      descriptions: map[Field.descriptions] as String?,
      status: map[Field.status] as String?,
      createdAt: map[Field.createdAt] as String?,
    );
  }
}
