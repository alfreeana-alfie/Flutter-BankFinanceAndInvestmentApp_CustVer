import 'package:flutter/material.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oktoast/oktoast.dart';


class CustomToast extends StatefulWidget {
  const CustomToast({ Key? key, this.text, this.backgroundColor }) : super(key: key);

  final String? text;
  final Color? backgroundColor;

  @override
  _CustomToastState createState() => _CustomToastState();
}

class _CustomToastState extends State<CustomToast> {
  @override
  Widget build(BuildContext context) {
    return showToast(
        Status.successTxt,
        backgroundColor: Styles.successColor,
        position: ToastPosition.bottom,
        textPadding: EdgeInsets.fromLTRB(40, 10, 40, 10),
        radius: 40,
      );
    );
  }
}