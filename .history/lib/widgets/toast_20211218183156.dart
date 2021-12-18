import 'package:flutter/material.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:fluttertoast/fluttertoast.dart';


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
      child: OkToas
    );
  }

  late FToast fToast;



_showToast(String text) {
    Widget toast = Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
        ),
        child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
            const Icon(Icons.check),
            const SizedBox(
            width: 12.0,
            ),
            Text(text),
        ],
        ),
    );


    fToast.showToast(
        child: toast,
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(seconds: 2),
    );
    
    // Custom Toast Position
    fToast.showToast(
        child: toast,
        toastDuration: Duration(seconds: 2),
        positionedToastBuilder: (context, child) {
          return Positioned(
            child: child,
            top: 16.0,
            left: 16.0,
          );
        });
}

}