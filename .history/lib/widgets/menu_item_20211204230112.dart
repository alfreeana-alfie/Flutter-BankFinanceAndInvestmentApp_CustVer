import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final Icon icon;
  final String title;
  final List
  const MenuItem(
      {Key? key, required this.icon, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.home),
      title: Text(contactUsText),
      onTap: () => {},
    );
  }
}
