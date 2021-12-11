import 'package:flutter_banking_app/pages/auth/forgot_password.dart';
import 'package:flutter_banking_app/pages/auth/sign_in.dart';
import 'package:flutter_banking_app/pages/auth/sign_up.dart';
import 'package:flutter_banking_app/pages/dashboard.dart';
import 'package:flutter_banking_app/pages/exchange_money.dart';
import 'package:flutter_banking_app/pages/fdr/apply_fdr.dart';
import 'package:flutter_banking_app/pages/fdr/fdr_history.dart';
import 'package:flutter_banking_app/pages/loans/apply_loan.dart';
import 'package:flutter_banking_app/pages/payment_request/new_request.dart';
import 'package:flutter_banking_app/pages/send_money.dart';
import 'package:flutter_banking_app/pages/tickets/new_ticket.dart';
import 'package:flutter_banking_app/pages/wire_transfer.dart';
import 'package:flutter_banking_app/utils/values.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'constant/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/bottom_nav.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var status = prefs.getBool('isLoggedIn') ?? false;
  status = false;

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
        // Forgot Password
        '/forgot_password': (context) => const ForgotPasswordPage(),
        // Sign Up
        '/sign_up': (context) => const SignUpPage(),
        // Sign In
        '/sign_in': (context) => const SignInPage(),
        '/bottom_nav': (context) => const BottomNav(),
        '/new-request': (context) => const NewRequest(),
        '/apply-new-loan': (context) => const ApplyNewLoan(),
        '/apply-new-fdr': (context) => const ApplyNewFDR(),
        // '/exchange_money': (context) => const ExchangeMoney(),
        // '/product_list': (context) => const ProductListPage(),
        // '/my_profile': (context) => const MyProfilePage(),
      },
      home: SplashScreenView(
        navigateRoute: status == true ? BottomNav() : SignInPage(),
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