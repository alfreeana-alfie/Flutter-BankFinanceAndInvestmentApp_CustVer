import 'package:flutter/material.dart';
import 'package:flutter_banking_app/pages/auth/forgot_password.dart';
import 'package:flutter_banking_app/pages/auth/sign_in.dart';
import 'package:flutter_banking_app/pages/auth/sign_up.dart';
import 'package:flutter_banking_app/pages/left-menu/about_us.dart';
import 'package:flutter_banking_app/pages/left-menu/contact_us.dart';
import 'package:flutter_banking_app/pages/left-menu/dashboard.dart';
import 'package:flutter_banking_app/pages/left-menu/faq.dart';
import 'package:flutter_banking_app/pages/left-menu/home.dart';
import 'package:flutter_banking_app/pages/left-menu/our_services.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'widgets/bottom_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'constant/string.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var status = prefs.getBool('isLoggedIn') ?? false;
  status = false;

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
        '/home': (context) => const HomePage(),
        '/about': (context) => const AboutUsPage(),
        '/services': (context) => const OurServicesPage(),
        '/faq': (context) => const FaqPage(),
        '/contact': (context) => const ContactUsPage(),
        '/dashboard': (context) => DashboardPage(),
        '/bottom_nav': (context) => const BottomNav(),
        // '/product_list': (context) => const ProductListPage(),
        // '/my_profile': (context) => const MyProfilePage(),
      },
      home: SplashScreenView(
        navigateRoute: status == true ? BottomNav() : SignInPage(),
        duration: 4000,
        imageSize: 200,
        imageSrc: 'assets/icons/delivery.png',
        text: "FVIS",
        backgroundColor: Styles.primaryColor,
        pageRouteTransition: PageRouteTransition.SlideTransition,
      ),
    ),
  );
}
