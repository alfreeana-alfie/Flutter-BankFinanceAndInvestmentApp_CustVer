import 'package:flutter_banking_app/utils/string.dart';

class Service {
  int? id;
  String? icon, createdAt;

  Service({this.id, this.icon, this.createdAt});
  
  
  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
        id: map[Field.id] as int?,
        
        icon: map[Field.icon] as String?,
        createdAt: map[Field.createdAt] as String?);
  }
}
