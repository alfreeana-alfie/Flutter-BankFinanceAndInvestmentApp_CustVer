import 'package:flutter_banking_app/utils/string.dart';

class Permission {
  String? name, permission; 

  Permission(
      {this.name,
      this.permission});

  factory Permission.fromMap(Map<String, dynamic> map) {
    return Permission(
      name: map[Field.name] as String?,
      permission: map[Field.permission] as String?
    );
  }
}
