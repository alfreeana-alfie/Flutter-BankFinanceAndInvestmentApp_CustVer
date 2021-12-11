import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/utils/iconly/iconly_light.dart';
import 'package:gap/gap.dart';

AppBar addAppBar({required String title, String? stringColor, required bool implyLeading, required BuildContext context, bool? hasAction, required }) {
  return AppBar(
    centerTitle: true,
    title: Text(title, style: TextStyle(color: Colors.white, fontSize: 18),),
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: implyLeading == true ? Transform.scale(
        scale: 0.7,
        child: IconButton(
          icon: Icon(Icons.keyboard_backspace_rounded, size: 33, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        )
    ) : SizedBox(),
    actions: [
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
        child: IconButton(
            icon: Icon(Icons.add, size: 33, color: Colors.white),
            onPressed: () => Navigator.pushNamed(context, ''),
          ),
      )
    ]
  );
}
