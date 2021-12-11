// import 'package:flutter_banking_app/pages/exchange_money.dart';
// import 'package:flutter_banking_app/pages/payment_request/new_request.dart';
import 'package:flutter_banking_app/pages/auth/forgot_password.dart';
import 'package:flutter_banking_app/pages/auth/sign_in.dart';
import 'package:flutter_banking_app/pages/auth/sign_up.dart';
import 'package:flutter_banking_app/pages/exchange_money.dart';
import 'package:flutter_banking_app/pages/send_money.dart';
import 'package:flutter_banking_app/pages/wire_transfer.dart';
// import 'package:flutter_banking_app/pages/wire_transfer.dart';
import 'package:flutter_banking_app/utils/values.dart';
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
  // status = true;

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
        // DashBoard
        '/dashboard': (context) => const DashboardPage(),
        // User Routes
        '/users': (context) => const UsersPage(),
        '/email-verified': (context) => const EmailVerifiedPage(),
        '/email-unverified': (context) => const EmailUnverifiedPage(),
        '/sms-verified': (context) => const SmsVerifiedPage(),
        '/sms-unverified': (context) => const SmsUnverifiedPage(),
        '/add-new-user': (context) => const AddNewUserPage(),
        // Transfer Request
        '/transfer-req': (context) => const TransferRequestPage(),
        // Deposit 
        '/deposit-req': (context) => const DepositRequestPage(),
        '/make-deposit': (context) => const MakeDepositPage(),
        '/deposit-hist': (context) => const DepositHistoryPage(),
        // Withdraw
        '/withdraw-req': (context) => const WithdrawRequestPage(),
        '/make-withdraw': (context) => const MakeWithdrawPage(),
        '/withdraw-hist': (context) => const WithdrawHistoryPage(),
        // Loan Management
        '/loans': (context) => const LoanListPage(),
        '/loan-cal': (context) => const LoanCalculatorPage(),
        '/add-new-loan': (context) => const AddNewLoanPage(),
        '/loan-prod': (context) => const LoanProductPage(),
        // Fixed Deposit
        '/fdr': (context) => const FdrListPage(),
        '/fdr-package': (context) => const FdrPackagePage(),
        // Gift Card
        '/gift-cards': (context) => const GiftCardListPage(),
        '/used-gift-cards': (context) => const UsedGiftCardPage(),
        // Support Ticket
        '/active-ticket': (context) => const ActiveTicketPage(),
        '/pending-ticket': (context) => const PendingTicketPage(),
        '/closed-ticket': (context) => const ClosedTicketPage(),
        '/add-new-ticket': (context) => const AddNewTicketPage(),
        // Branches
        // Other Banks
        // System Users
        '/sys-users': (context) => const SysUserListPage(),
        '/user-roles': (context) => const UserRolesPage(),
        '/access-control': (context) => const AccessControlPage(),
        // Currency List
        // Transaction Settings
        '/trans-deposit-meth': (context) => const DepositMethodsPage(),
        '/trans-deposit-gate': (context) => const DepositGatewayPage(),
        '/trans-withdraw-meth': (context) => const WithdrawMethodsPage(),
        '/trans-fees': (context) => const TransactionFeePage(),
        // Website Management
        '/faq': (context) => const FaqPage(),
        '/services': (context) => const ServicesPage(),
        '/pages': (context) => const CmsPage(),
        '/teams': (context) => const TeamsPage(),
        '/testimonials': (context) => const TestimonialsPage(),
        '/theme-opt': (context) => const ThemeOptPage(),
        '/menu-manage': (context) => const MenuManagementPage(),
        // Administration
        '/general-settings': (context) => const GeneralSettingsPage(),
        '/db-backup': (context) => const DatabaseBackupPage(),
        // Languages
        '/langs': (context) => const LangListPage(),
        '/add-lang': (context) => const AddNewLangPage(),
        // Sign Out
      },
      home: SplashScreenView(
        // navigateRoute: status == true ? BottomNav() : SignInPage(),
        navigateRoute: UsersPage(),
        duration: 4000,
        imageSize: 200,
        imageSrc: Values.logoPath,
        text: Str.appNameTxt,
        backgroundColor: Styles.primaryColor,
        pageRouteTransition: PageRouteTransition.SlideTransition,
      ),
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Styles.secondaryColor,
        errorColor: Styles.dangerColor,
        textTheme: TextTheme(
          headline5: GoogleFonts.roboto(fontWeight: FontWeight.w400, letterSpacing:0.0, fontSize: 22, color: Styles.textColor),
          headline6: GoogleFonts.roboto(fontWeight: FontWeight.w500, letterSpacing:0.15, fontSize: 16, color: Styles.textColor),
          button: GoogleFonts.roboto(fontWeight: FontWeight.w500, letterSpacing:0.75, fontSize: 14, color: Styles.primaryColor),
          bodyText1: GoogleFonts.nunitoSans(fontWeight: FontWeight.w400, letterSpacing:0.5, fontSize: 15, color: Styles.textColor.withOpacity(0.7)),
          bodyText2: GoogleFonts.nunitoSans(fontWeight: FontWeight.w400, letterSpacing:0.25, fontSize: 15, color: Styles.textColor),
        ),
      ),
    ),
  );
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  var status = prefs.getBool('isLoggedIn') ?? false;
  // status = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
