import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({ Key? key, required  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.home),
      title: Text(contactUsText),
      onTap: () => {},
    );
  }
}