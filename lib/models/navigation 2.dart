import 'package:flutter_banking_app/utils/string.dart';

class Navigation {
  int? id;
  String? name, createdAt, status;

   Navigation(
      {this.id,
      this.name,
      this.status,
      this.createdAt});

  factory Navigation.fromMap(Map<String, dynamic> map) {
    return Navigation(
      id: map[Field.id] as int?,
      name: map[Field.name] as String?,
      status: map[Field.status] as String?,
      createdAt: map[Field.createdAt] as String?,
    );
  }
}
