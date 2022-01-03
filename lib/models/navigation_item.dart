import 'package:flutter_banking_app/utils/string.dart';

class NavigationItem {
  int? position, pageId, status;
  String? name, type, url, icon, target, parentId, cssClass, cssId;

   NavigationItem(
      {this.name,
      this.type,
      this.pageId,
      this.url,
      this.icon, 
      this.target,
      this.parentId, 
      this.position, 
      this.status, 
      this.cssClass, 
      this.cssId});

  factory NavigationItem.fromMap(Map<String, dynamic> map) {
    return NavigationItem(
      name: map[Field.name] as String?,
      type: map[Field.type] as String?,
      pageId: map[Field.pageId] as int?,
      url: map[Field.url] as String?,
      icon: map[Field.icon] as String?,
      target: map[Field.target] as String?,
      parentId: map[Field.parentId] as String?,
      position: map[Field.position] as int?,
      status: map[Field.status] as int?,
      cssClass: map[Field.cssClass] as String?,
      cssId: map[Field.cssId] as String?,
    );
  }
}
