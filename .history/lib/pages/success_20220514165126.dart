import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
          title: Str.upgrade, implyLeading: true, context: context),
      body: 
    );
  }
}