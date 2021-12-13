import 'dart:io';

import 'package:flutter_banking_app/methods/auth_methods.dart';
import 'package:flutter_banking_app/pages/auth/forgot_password.dart';
import 'package:flutter_banking_app/pages/auth/profile_overview.dart';
import 'package:flutter_banking_app/pages/auth/sign_in.dart';
import 'package:flutter_banking_app/pages/auth/sign_up.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/values.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/bottom_nav.dart';

import 'methods/config.dart';
import 'pages/member/fdr/apply_fdr.dart';
import 'pages/member/loans/apply_loan.dart';
import 'pages/member/payment_request/new_request.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  var status = prefs.getBool(Pref.isLoggedIn) ?? false;

  runApp(
    MaterialApp(
      title: Str.appNameTxt,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'DMSans',
        primaryColor: Styles.primaryColor,
        backgroundColor: Styles.primaryColor,
      ),
      routes: {
        // AUTH - MEMBER & ADMIN
        RouteSTR.forgotPassword:  (context) => const ForgotPasswordPage(),
        RouteSTR.signUp:          (context) => const SignUpPage(),
        RouteSTR.signIn:          (context) => const SignInPage(),

        // MEMBER ROUTE(S)
        RouteSTR.dashboardMember: (context) => const BottomNav(),
        RouteSTR.bottomNav:       (context) => const BottomNav(),
        RouteSTR.newRequest:      (context) => const NewRequest(),
        RouteSTR.applyNewLoan:    (context) => const ApplyNewLoan(),
        RouteSTR.applyNewFDR:     (context) => const ApplyNewFDR(),

        // ADMIN ROUTE(S)
        RouteSTR.
      },
      home: SplashScreenView(
        navigateRoute: status == true ? const BottomNav() : const SignInPage(),
        duration: 4000,
        imageSize: 200,
        imageSrc: Values.logoPath,
        text: Str.appNameTxt,
        textStyle: Styles.headingStyle01,
        backgroundColor: Styles.primaryColor,
        pageRouteTransition: PageRouteTransition.SlideTransition,
      ),
    ),
  );
}