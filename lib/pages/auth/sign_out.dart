import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/pages/auth/sign_in.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';

class SignOut extends StatefulWidget {
  const SignOut({ Key? key }) : super(key: key);

  @override
  _SignOutState createState() => _SignOutState();
}

class _SignOutState extends State<SignOut> {
  SharedPref sharedPref = SharedPref();

  Future check() async {
    sharedPref.remove(Pref.expiredAt);
    sharedPref.remove(Pref.accessToken);
    sharedPref.remove(Pref.userData);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: _innerContainer()
    );
  }

  _innerContainer() {
    return FutureBuilder(
      future: check(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Styles.accentColor,
            ),
          );
        } else {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return const SignInPage();
          }
        }
      },
    );
  }
}