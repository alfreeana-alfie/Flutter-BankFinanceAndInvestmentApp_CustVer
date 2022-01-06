import 'package:flutter_banking_app/utils/string.dart';

class NavigationItem {
  int? id;
  String? name,
      type,
      url,
      icon,
      target,
      cssClass,
      cssId,
      navigationId,
      position,
      pageId,
      parentId,
      status;

  NavigationItem(
      {this.id,
      this.navigationId,
      this.name,
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
      id: map[Field.id] as int?,
      navigationId: map[Field.navigationId] as String?,
      name: map[Field.name] as String?,
      type: map[Field.type] as String?,
      pageId: map[Field.pageId] as String?,
      url: map[Field.url] as String?,
      icon: map[Field.icon] as String?,
      target: map[Field.target] as String?,
      parentId: map[Field.parentId] as String?,
      position: map[Field.position] as String?,
      status: map[Field.status] as String?,
      cssClass: map[Field.cssClass] as String?,
      cssId: map[Field.cssId] as String?,
    );
  }
}
