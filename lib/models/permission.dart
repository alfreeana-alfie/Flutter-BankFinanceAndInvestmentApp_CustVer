import 'package:flutter_banking_app/utils/string.dart';

class Permission {
  int? id;
  String? name, permission, roleId;

  Permission({this.id, this.roleId, this.name, this.permission});

  factory Permission.fromMap(Map<String, dynamic> map) {
    return Permission(
        id: map[Field.id] as int?,
        roleId: map[Field.roleId] as String?,
        name: map[Field.name] as String?,
        permission: map[Field.permission] as String?);
  }
}
