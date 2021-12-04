import 'package:flutter/material.dart';
import 'package:flutter_banking_app/pages/left-menu/contact_us.dart';
import 'package:flutter_banking_app/pages/left-menu/dashboard.dart';
import 'package:flutter_banking_app/pages/left-menu/forgot_password.dart';
import 'package:flutter_banking_app/pages/left-menu/sign_in.dart';
import 'package:flutter_banking_app/pages/left-menu/sign_up.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/bottom_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'FVIS',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         fontFamily: 'DMSans',
//         primaryColor: Styles.primaryColor,
//         backgroundColor: Styles.primaryColor,
//       ),
//       home: const BottomNav(),
//     );
//   }
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var status = prefs.getBool('isLoggedIn') ?? false;
  status = true;

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Local Brands',
      routes: {
        '/forgot': (context) => const ForgotPasswordPage(),
        '/sign_up': (context) => const SignUpPage(),
        '/home': (context) => const HomePage(),
        '/about': (context) => const AboutPage(),
        '/services': (context) => const AboutPage(),
        '/faq': (context) => const About(),
        '/contact': (context) => const ContactUsPage(),
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
