import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_banking_app/pages/member/dashboard.dart';
import 'package:oktoast/oktoast.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'pages/account_manager/dashboard.dart';
import 'pages/accountant/dashboard.dart';
import 'pages/admin/dashboard.dart';
import 'pages/admin/transaction/exchange_money/exchange_money_list.dart';
import 'pages/admin/transaction/send_money/send_money_list.dart';
import 'pages/admin/transaction/wire_transfer/wire_list.dart';
import 'pages/admin/users/assign_role.dart';
import 'pages/auth/forgot_password.dart';
import 'pages/auth/profile_overview.dart';
import 'pages/auth/sign_in.dart';
import 'pages/auth/sign_up.dart';
import 'pages/coming_soon.dart';
import 'pages/coming_soon_menu.dart';
import 'pages/member/exchange_money/add_exchange_money.dart';
import 'pages/member/exchange_money/exchange_money_list.dart';
import 'pages/member/fdr/add_fdr.dart';
import 'pages/member/fdr/fdr_list.dart';
import 'pages/member/loans/add_loan.dart';
import 'pages/member/loans/loan_cal.dart';
import 'pages/member/loans/loan_list.dart';
import 'pages/member/membership/upgrade_plan.dart';
import 'pages/member/payment_request/add_payment_request.dart';
import 'pages/member/payment_request/payment_request_list.dart';
import 'pages/member/send_money/add_send_money.dart';
import 'pages/member/send_money/send_money_list.dart';
import 'pages/member/stats.dart';
import 'pages/member/ticket/create_ticket.dart';
import 'pages/member/ticket/ticket_list.dart';
import 'pages/member/wallet/top_up.dart';
import 'pages/member/wire_transfer/wire_transfer.dart';
import 'pages/member/wire_transfer/wire_transfer_list.dart';
import 'pages/member/withdraw/create_withdraw.dart';
import 'pages/member/withdraw/withdraw_list.dart';
import 'utils/string.dart';
import 'utils/styles.dart';
import 'utils/values.dart';
import 'widgets/bottom_nav.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    OKToast(
      child: MaterialApp(
        home: SplashScreenView(
          navigateRoute: const MCreateLoan(),
          duration: 4000,
          imageSize: 200,
          imageSrc: Values.logoPath,
          text: Str.appName,
          textStyle: Styles.titleApp,
          backgroundColor: Styles.primaryColor,
          pageRouteTransition: PageRouteTransition.SlideTransition,
        ),
        title: Str.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'DMSans',
          primaryColor: Styles.primaryColor,
          backgroundColor: Styles.primaryColor,
        ),
        darkTheme: ThemeData(
          fontFamily: 'DMSans',
          primaryColor: Styles.primaryColorDark,
          backgroundColor: Styles.primaryColorDark,
        ),
        routes: {
          RouteSTR.comingSoon: (context) => const ComingSoon(),
          RouteSTR.comingSoonMenu: (context) => const ComingSoonMenu(),

          // AUTH - MEMBER & ADMIN
          RouteSTR.forgotPassword: (context) => const ForgotPasswordPage(),
          RouteSTR.signUp: (context) => const SignUpPage(),
          RouteSTR.signIn: (context) => const SignInPage(),
          RouteSTR.profileOverview: (context) => const ProfileOverview(),

          // MEMBER ROUTE(S)
          RouteSTR.dashboardMember: (context) => const BottomNav(),
          RouteSTR.dashboardAccountant: (context) => const AccountDashboard(),
          RouteSTR.dashboardAccountManager: (context) => const AccountManagementDashboard(),

          RouteSTR.bottomNav: (context) => const BottomNav(),

          RouteSTR.topUpWallet: (context) => const MTopUpWallet(),

          RouteSTR.paymentRequestM: (context) => const MPaymentRequestList(),
          RouteSTR.addPaymentRequestM: (context) =>
              const MCreatePaymentRequest(),

          RouteSTR.withdrawM: (context) => const MCreateWithdraw(),

          RouteSTR.sendMoneyM: (context) => const MCreateSendMoney(),
          RouteSTR.sendMoneyListM: (context) => const MSendMoneyList(),

          RouteSTR.exchangeMoneyM: (context) => const MCreateExchangeMoney(),
          RouteSTR.exchangeMoneyListM: (context) => const MExchangeMoneyList(),

          RouteSTR.wireTransferM: (context) => const MCreateWireTransfer(),
          RouteSTR.wireTransferListM: (context) => const MWireTransferList(),

          RouteSTR.createWithdraw: (context) => const MCreateWithdraw(),
          RouteSTR.withdrawListM: (context) => const MWithdrawList(),

          RouteSTR.addLoanM: (context) => const MCreateLoan(),
          RouteSTR.loanListM: (context) => const MLoanList(),

          RouteSTR.addFdrM: (context) => const MCreateFDR(),
          RouteSTR.fdrListM: (context) => const MFdrList(),

          RouteSTR.supportTicketListM: (context) => const MSupportTicketList(),
          RouteSTR.addSupportTicketM: (context) => const MCreateSupportTicket(),

          RouteSTR.statsM: (context) => const Stats(),

          RouteSTR.upgradeMembershipM: (context) =>
              const MUpgradeMembershipPlan(),

          // ADMIN ROUTE(S)
          RouteSTR.dashboardAdmin: (context) => const AdminDashboard(),

          RouteSTR.assignRole: (context) => const AssignRole(),

          RouteSTR.wireTransferList: (context) => const WireTransferList(),
          RouteSTR.sendMoneyList: (context) => const SendMoneyList(),
          RouteSTR.exchangeMoneyList: (context) => const ExchangeMoneyList(),

          RouteSTR.loanCalculator: (context) => const LoanCalculator(),
        },
      ),
    ),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
