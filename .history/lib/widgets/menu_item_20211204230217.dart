import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final Icon icon;
  final Text title;
  final Function() onTap;

  const MenuItem(
      {Key? key, required this.icon, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: title,
      onTap: onTap,
    );
  }
}
