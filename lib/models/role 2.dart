import 'package:flutter_banking_app/utils/string.dart';

class UserRole {
  int? id;
  String? name, description, createdAt;

  UserRole(
      {this.id,
      this.name,
      this.description,
      this.createdAt});

  factory UserRole.fromMap(Map<String, dynamic> map) {
    return UserRole(
      id: map[Field.id] as int?,
      name: map[Field.name] as String?,
      description: map[Field.description] as String?,
      createdAt: map[Field.createdAt] as String?
    );
  }
}
