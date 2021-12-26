import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/left_menu.dart';

class ComingSoonMenu extends StatelessWidget {
  const ComingSoonMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.accentColor,
        centerTitle: false,
        elevation: 0.0,
      ),
      drawer: const SideDrawer(),
      body: Material(
        color: Styles.primaryColor,
        elevation: 0,
        child: Container(
          alignment: Alignment.center,
          child: Text(
            Str.comingSoonTxt,
            style: const TextStyle(
              color: Styles.textColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
