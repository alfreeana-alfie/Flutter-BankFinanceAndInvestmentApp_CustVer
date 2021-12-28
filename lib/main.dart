import 'dart:io';

import 'package:flutter/material.dart';

import 'pages/admin/loan_managements/create_loan_product.dart';
import 'pages/admin/loan_managements/loan_cal.dart';
import 'pages/admin/loan_managements/loan_product_list.dart';


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
  // final prefs = await SharedPreferences.getInstance();
  // var status = prefs.getBool(Pref.isLoggedIn) ?? false;

  runApp(
    const MaterialApp(home: LoanProductList()),
  // );
    // MaterialApp(
    //   home: SplashScreenView(
    //     navigateRoute: const CreateDeposit(),
    //     duration: 4000,
    //     imageSize: 200,
    //     imageSrc: Values.logoPath,
    //     text: Str.appNameTxt,
    //     textStyle: Styles.headingStyle01,
    //     backgroundColor: Styles.primaryColor,
    //     pageRouteTransition: PageRouteTransition.SlideTransition,
    //   ),
    //   title: Str.appNameTxt,
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(
    //     fontFamily: 'DMSans',
        
    //     primaryColor: Styles.primaryColor,
    //     backgroundColor: Styles.primaryColor,
    //   ),
    //   darkTheme: ThemeData(
    //     fontFamily: 'DMSans',
    //     primaryColor: Styles.primaryColorDark,
    //     backgroundColor: Styles.primaryColorDark,
    //   ),
    //   routes: {
    //     RouteSTR.comingSoon:            (context) => const ComingSoon(),
    //     RouteSTR.comingSoonMenu:        (context) => const ComingSoonMenu(),
    //     // AUTH - MEMBER & ADMIN
    //     RouteSTR.forgotPassword:        (context) => const ForgotPasswordPage(),
    //     RouteSTR.signUp:                (context) => const SignUpPage(),
    //     RouteSTR.signIn:                (context) => const SignInPage(),

    //     // MEMBER ROUTE(S)
    //     RouteSTR.dashboardMember:       (context) => const BottomNav(),
    //     RouteSTR.bottomNav:             (context) => const BottomNav(),

    //     RouteSTR.paymentRequestM:       (context) => const MPaymentRequestList(),
    //     RouteSTR.addPaymentRequestM:    (context) => const MCreatePaymentRequest(),

    //     RouteSTR.sendMoneyM:            (context) => const MCreateSendMoney(),
    //     // RouteSTR.sendMoneyListM:        (context) => const MSendMoneyList(),

    //     RouteSTR.exchangeMoneyM:        (context) => const MCreateExchangeMoney(),
    //     // RouteSTR.exchangeMoneyListM:    (context) => const MExchangeMoneyList(),

    //     RouteSTR.wireTransferM:         (context) => const MCreateWireTransfer(),
    //     // RouteSTR.wireTransferListM:     (context) => const MWireTransferList(),

    //     RouteSTR.addLoanM:              (context) => const MCreateLoan(),
    //     RouteSTR.loanListM:             (context) => const MLoanList(),

    //     RouteSTR.addFdrM:               (context) => const MCreateFDR(),
    //     RouteSTR.fdrListM:              (context) => const MFdrList(),

    //     // ADMIN ROUTE(S)
    //     RouteSTR.dashboardAdmin:      (context) => const AdminDashboard(),

    //     RouteSTR.depositList:         (context) => const DepositList(),
    //     RouteSTR.createDeposit:       (context) => const CreateDeposit(),

    //     RouteSTR.usersList:           (context) => const UsersList(),
    //     RouteSTR.createUsers:         (context) => const CreateUsers(),

    //     RouteSTR.wireTransferList:    (context) => const WireTransferList(),
    //     RouteSTR.createWireTransfer:  (context) => const CreateWireTransfer(),

    //     RouteSTR.loanProductList:     (context) => const LoanProductList(),
    //     RouteSTR.createLoanProduct:   (context) => const CreateLoanProduct(),

    //     RouteSTR.fdrPlanList:         (context) => const FdrPlanList(),
    //     RouteSTR.createPlanFDR:       (context) => const CreateFdrPackage(),

    //     RouteSTR.branchList:          (context) => const BranchList(),
    //     RouteSTR.createBranch:        (context) => const CreateBranch(),

    //     RouteSTR.otherBankList:       (context) => const OtherBankList(),
    //     RouteSTR.createBank:          (context) => const CreateOtherBank(),

    //     RouteSTR.currencyList:        (context) => const CurrencyList(),
    //     RouteSTR.createCurrency:      (context) => const CreateCurrency(),

    //     RouteSTR.serviceList:         (context) => const ServiceList(),
    //     RouteSTR.createService:       (context) => const CreateService(),

    //     RouteSTR.faqList:             (context) => const FaqList(),
    //     RouteSTR.createFaq:           (context) => const CreateFaq(),

    //     RouteSTR.teamList:            (context) => const TeamList(),
    //     RouteSTR.createService:       (context) => const CreateTeam(),

    //     RouteSTR.testimonialList:     (context) => const TestimonialList(),
    //     RouteSTR.createTestimonial:   (context) => const CreateTestimonial(),
    //   },
    // ),
  );
}
