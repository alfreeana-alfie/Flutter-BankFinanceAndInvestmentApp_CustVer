import 'package:flutter_banking_app/utils/string.dart';

class Team {
  int? id;
  String? name, image, role, createdAt;

  Team({this.id, 
  this.name, 
  this.image, 
  this.role, 
  this.createdAt});

  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
        id: map[Field.id] as int?,
        name: map[Field.name] as String?,
        image: map[Field.image] as String?,
        role: map[Field.role] as String?,
        createdAt: map[Field.createdAt] as String?);
  }
}
