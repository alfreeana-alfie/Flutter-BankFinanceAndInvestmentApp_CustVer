import 'package:flutter/material.dart';

class ToastNoContext extends StatelessWidget {
  const ToastNoContext({Key? key, this.text, this.backgroundColor}) : super(key: key);

  final String? text;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Fluttertoast.showToast(
          msg: Status.failedTxt,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Styles.dangerColor,
          textColor: Styles.whiteColor,
          fontSize: 16);
  }
}
