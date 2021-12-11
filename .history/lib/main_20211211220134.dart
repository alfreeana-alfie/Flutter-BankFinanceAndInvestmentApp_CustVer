<<<<<<< Updated upstream
=======
// import 'package:flutter_banking_app/pages/exchange_money.dart';
// import 'package:flutter_banking_app/pages/payment_request/new_request.dart';
import 'package:flutter_banking_app/pages/exchange_money.dart';
import 'package:flutter_banking_app/pages/send_money.dart';
import 'package:flutter_banking_app/pages/wire_transfer.dart';
// import 'package:flutter_banking_app/pages/wire_transfer.dart';
import 'package:flutter_banking_app/utils/values.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'constant/string.dart';
>>>>>>> Stashed changes
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/bottom_nav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FVIS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'DMSans',
        primaryColor: Styles.primaryColor,
        backgroundColor: Styles.primaryColor,
      routes: {
        // Forgot Password
        '/forgot_password': (context) => const ForgotPasswordPage(),
        // Sign Up
        '/sign_up': (context) => const SignUpPage(),
        // Sign In
        '/sign_in': (context) => const SignInPage(),
        '/bottom_nav': (context) => const BottomNav(),
        // '/exchange_money': (context) => const ExchangeMoney(),
        // '/product_list': (context) => const ProductListPage(),
        // '/my_profile': (context) => const MyProfilePage(),
      },
      home: SplashScreenView(
        navigateRoute: status == true ? ExchangeMoney() : SignInPage(),
        duration: 4000,
        imageSize: 200,
        imageSrc: Values.logoPath,
        text: Str.appNameTxt,
        backgroundColor: Styles.whiteColor,
        pageRouteTransition: PageRouteTransition.SlideTransition,
      ),
    );
}
