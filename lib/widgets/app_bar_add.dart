import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar addAppBar({required String title, String? stringColor, required bool implyLeading, required BuildContext context, bool? hasAction, required path}) {
  return AppBar(
    centerTitle: true,
    title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 18),),
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: implyLeading == true ? Transform.scale(
        scale: 0.7,
        child: IconButton(
          icon: const Icon(Icons.keyboard_backspace_rounded, size: 33, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        )
    ) : const SizedBox(),
    actions: [
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
        child: IconButton(
            icon: const Icon(Icons.add, size: 33, color: Colors.white),
            onPressed: () => Navigator.pushNamed(context, path),
          ),
      )
    ]
  );
}
