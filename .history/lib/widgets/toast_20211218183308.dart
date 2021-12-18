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
  void initState() {
      super.initState();
      fToast = FToast();
      fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: OKToast(child: Container(
        child: Text(widget.text ?? '-'),
        color: widget.backgroundColor,
      ),),
    );
  }
}