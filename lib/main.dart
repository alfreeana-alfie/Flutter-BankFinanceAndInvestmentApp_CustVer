import 'dart:io';

import 'package:flutter_banking_app/pages/admin/branches/branch_list.dart';
import 'package:flutter_banking_app/pages/admin/branches/create_branch.dart';
import 'package:flutter_banking_app/pages/admin/currency/create_currency.dart';
import 'package:flutter_banking_app/pages/admin/currency/currency_list.dart';
import 'package:flutter_banking_app/pages/admin/dashboard.dart';
import 'package:flutter_banking_app/pages/admin/deposit/create_deposit.dart';
import 'package:flutter_banking_app/pages/admin/deposit/deposit_list.dart';
import 'package:flutter_banking_app/pages/admin/fdr/fdr_plans_list.dart';
import 'package:flutter_banking_app/pages/admin/loan_managements/loan_product_list.dart';
import 'package:flutter_banking_app/pages/admin/other_banks/bank_list.dart';
import 'package:flutter_banking_app/pages/admin/other_banks/create_bank.dart';
import 'package:flutter_banking_app/pages/admin/users/create_users.dart';
import 'package:flutter_banking_app/pages/admin/users/users_list.dart';
import 'package:flutter_banking_app/pages/admin/wire_transfer/wire_list.dart';
import 'package:flutter_banking_app/pages/admin/wire_transfer/wire_transfer.dart';
import 'package:flutter_banking_app/pages/auth/forgot_password.dart';
import 'package:flutter_banking_app/pages/auth/sign_in.dart';
import 'package:flutter_banking_app/pages/auth/sign_up.dart';
import 'package:flutter_banking_app/pages/coming_soon.dart';
import 'package:flutter_banking_app/pages/coming_soon_menu.dart';
import 'package:flutter_banking_app/pages/member/exchange_money/add_exchange_money.dart';
import 'package:flutter_banking_app/pages/member/payment_request/add_payment_request.dart';
import 'package:flutter_banking_app/pages/member/payment_request/payment_request_list.dart';
import 'package:flutter_banking_app/pages/member/send_money/add_send_money.dart';
import 'package:flutter_banking_app/pages/member/wire_transfer/wire_transfer.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/values.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/bottom_nav.dart';

import 'pages/member/fdr/add_fdr.dart';
import 'pages/member/loans/add_loan.dart';

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
    MaterialApp(
      home: SplashScreenView(
        navigateRoute: AdminDashboard(),
        duration: 4000,
        imageSize: 200,
        imageSrc: Values.logoPath,
        text: Str.appNameTxt,
        textStyle: Styles.headingStyle01,
        backgroundColor: Styles.primaryColor,
        pageRouteTransition: PageRouteTransition.SlideTransition,
      ),
      title: Str.appNameTxt,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'DMSans',
        primaryColor: Styles.primaryColor,
        backgroundColor: Styles.primaryColor,
      ),
      routes: {
        RouteSTR.comingSoon: (context) => const ComingSoon(),
        RouteSTR.comingSoonMenu: (context) => const ComingSoonMenu(),
        // AUTH - MEMBER & ADMIN
        RouteSTR.forgotPassword:  (context) => const ForgotPasswordPage(),
        RouteSTR.signUp:          (context) => const SignUpPage(),
        RouteSTR.signIn:          (context) => const SignInPage(),

        // MEMBER ROUTE(S)
        RouteSTR.dashboardMember: (context) => const BottomNav(),
        RouteSTR.bottomNav:       (context) => const BottomNav(),
        
        // RouteSTR.allRequestM:      (context) => const MPaymentRequestList(),
        // RouteSTR.newRequestM:      (context) => const MCreatePaymentRequest(),

        // RouteSTR.sendMoneyM:          (context) => const MCreateSendMoney(),
        // RouteSTR.sendMoneyListM:      (context) => const MSendMoneyList(),
        
        // RouteSTR.exchangeMoneyM:      (context) => const MCreateExchangeMoney(),
        // RouteSTR.exchangeMoneyListM: (context) => const MExchangeMoneyList(),

        // RouteSTR.wireTransferM:     (context) => const MCreateWireTransfer(),
        // RouteSTR.wireTransferListM: (context) => const MWireTransferList(),

        // RouteSTR.applyNewLoan:      (context) => const MCreateLoan(),
        // RouteSTR.loanListM:         (context) => const MLoanList(),

        // RouteSTR.applyNewFDR:       (context) => const MCreateFDR(),
        // RouteSTR.fdrListM:          (context) => const MFdrList(),

        // ADMIN ROUTE(S)
        RouteSTR.dashboardAdmin:      (context) => const AdminDashboard(),

        RouteSTR.depositList:         (context) => const DepositList(),
        RouteSTR.createDeposit:       (context) => const CreateDeposit(),

        RouteSTR.usersList:           (context) => const UsersList(),
        RouteSTR.createUsers:         (context) => const CreateUsers(),

        RouteSTR.wireTransferList:    (context) => const UsersList(),
        RouteSTR.createWireTransfer:  (context) => const CreateWireTransfer(),

        RouteSTR.loanProductList:     (context) => const LoanProductList(),
        RouteSTR.createLoanProduct:   (context) => const CreateWireTransfer(),

        RouteSTR.fdrPlanList:         (context) => const FdrPlanList(),
        RouteSTR.createPlanFDR:       (context) => const CreateWireTransfer(),

        RouteSTR.branchList:          (context) => const BranchList(),
        RouteSTR.createBranch:        (context) => const CreateBranch(),

        RouteSTR.otherBankList:       (context) => const OtherBankList(),
        RouteSTR.createBank:          (context) => const CreateOtherBank(),
        
        RouteSTR.currencyList:        (context) => const CurrencyList(),
        RouteSTR.createCurrency:      (context) => const CreateCurrency(),
      },
      
    ),
  );
}