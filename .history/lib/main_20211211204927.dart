import 'package:flutter_banking_app/pages/exchange_money.dart';
import 'package:flutter_banking_app/pages/payment_request/new_request.dart';
import 'package:flutter_banking_app/pages/send_money.dart';
import 'package:flutter_banking_app/pages/wire_transfer.dart';
import 'package:flutter_banking_app/utils/values.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'constant/string.dart';
import 'package:flutter/material.dart';
import 'pages/auth/forgot_password.dart';
import 'pages/auth/sign_in.dart';
import 'pages/auth/sign_up.dart';
import 'utils/styles.dart';
import 'widgets/bottom_nav.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var status = prefs.getBool('isLoggedIn') ?? false;
  status = true;

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Str.appNameTxt,
      routes: {
        // Forgot Password
        '/forgot_password': (context) => const ForgotPasswordPage(),
        // Sign Up
        '/sign_up': (context) => const SignUpPage(),
        // Sign In
        '/sign_in': (context) => const SignInPage(),
        '/bottom_nav': (context) => const BottomNav(),
        '/exchange_money': (context) => const ExchangeMoney(),
        // '/product_list': (context) => const ProductListPage(),
        // '/my_profile': (context) => const MyProfilePage(),
      },
      home: SplashScreenView(
        navigateRoute: status == true ? SendMoney() : SignInPage(),
        duration: 4000,
        imageSize: 200,
        imageSrc: Values.logoPath,
        text: Str.appNameTxt,
        backgroundColor: Styles.whiteColor,
        pageRouteTransition: PageRouteTransition.SlideTransition,
      ),
    ),
  );
}
