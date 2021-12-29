import 'package:flutter_banking_app/utils/string.dart';

class Navigation {
  int? id, status;
  String? name, createdAt;

   Navigation(
      {this.id,
      this.name,
      this.status,
      this.createdAt});

  factory Navigation.fromMap(Map<String, dynamic> map) {
    return Navigation(
      id: map[Field.id] as int?,
      name: map[Field.name] as String?,
      status: map[Field.status] as int?,
      createdAt: map[Field.createdAt] as String?,
    );
  }
}
