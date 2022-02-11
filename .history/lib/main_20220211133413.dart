import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_banking_app/pages/admin/ticket/create_ticket.dart';
import 'package:flutter_banking_app/pages/admin/users/create_permission.dart';
import 'package:flutter_banking_app/pages/auth/sign_out.dart';
import 'package:flutter_banking_app/pages/member/exchange_money/exchange_money_list.dart';
import 'package:flutter_banking_app/pages/member/send_money/send_money_list.dart';
import 'package:flutter_banking_app/pages/member/stats.dart';
import 'package:flutter_banking_app/pages/member/membership/upgrade_plan.dart';
import 'package:flutter_banking_app/pages/member/wallet/add_card.dart';
import 'package:flutter_banking_app/pages/member/wire_transfer/wire_transfer_list.dart';
import 'package:oktoast/oktoast.dart';
import 'pages/admin/gift_card/create_gift_card.dart';
import 'pages/admin/navigation/create_navigation.dart';
import 'pages/admin/navigation/create_navigation_item.dart';
import 'pages/admin/users/assign_role.dart';
import 'pages/admin/users/create_user_role.dart';
import 'pages/member/loans/loan_cal.dart';
import 'pages/member/ticket/create_ticket.dart';
import 'pages/member/ticket/ticket_list.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'pages/admin/branches/create_branch.dart';
import 'pages/admin/currency/create_currency.dart';
import 'pages/admin/dashboard.dart';
import 'pages/admin/deposit/create_deposit.dart';
import 'pages/admin/faq/create_faq.dart';
import 'pages/admin/fdr/create_fdr_packages.dart';
import 'pages/admin/loan_managements/create_loan_product.dart';
import 'pages/admin/other_banks/create_bank.dart';
import 'pages/admin/service/create_service.dart';
import 'pages/admin/team/create_team.dart';
import 'pages/admin/testimonial/create_testimonial.dart';
import 'pages/admin/transaction/create_wire_transfer.dart';
import 'pages/admin/users/create_users.dart';
import 'pages/auth/forgot_password.dart';
import 'pages/auth/profile_overview.dart';
import 'pages/auth/sign_in.dart';
import 'pages/auth/sign_up.dart';
import 'pages/coming_soon.dart';
import 'pages/coming_soon_menu.dart';
import 'pages/member/exchange_money/add_exchange_money.dart';
import 'pages/member/fdr/add_fdr.dart';
import 'pages/member/fdr/fdr_list.dart';
import 'pages/member/loans/add_loan.dart';
import 'pages/member/loans/loan_list.dart';
import 'pages/member/payment_request/add_payment_request.dart';
import 'pages/member/payment_request/payment_request_list.dart';
import 'pages/member/send_money/add_send_money.dart';
import 'pages/member/wire_transfer/wire_transfer.dart';
import 'utils/string.dart';
import 'utils/styles.dart';
import 'utils/values.dart';
import 'widgets/bottom_nav.dart';

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
  
  runApp(
    OKToast(
      child: MaterialApp(
        home: SplashScreenView(
          navigateRoute: const AdminDashboard(),
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
          RouteSTR.signOut: (context) => const SignOut(),
          RouteSTR.profileOverview: (context) => const ProfileOverview(),
    
          // MEMBER ROUTE(S)
          RouteSTR.dashboardMember: (context) => const BottomNav(),
          RouteSTR.dashboardAccountant: (context) => const AccountDashboard(),
          RouteSTR.bottomNav: (context) => const BottomNav(),
    
          RouteSTR.topUpWallet: (context) => const MTopUpWallet(),
          // RouteSTR.rateList: (context) => const RateList(),
          // RouteSTR.walletTransactionList: (context) => const WalletTransactionList(),
    
          RouteSTR.paymentRequestM: (context) => const MPaymentRequestList(),
          RouteSTR.addPaymentRequestM: (context) => const MCreatePaymentRequest(),
    
          RouteSTR.sendMoneyM: (context) => const MCreateSendMoney(),
          RouteSTR.sendMoneyListM: (context) => const MSendMoneyList(),
    
          RouteSTR.exchangeMoneyM: (context) => const MCreateExchangeMoney(),
          RouteSTR.exchangeMoneyListM: (context) => const MExchangeMoneyList(),
    
          RouteSTR.wireTransferM: (context) => const MCreateWireTransfer(),
          RouteSTR.wireTransferListM: (context) => const MWireTransferList(),
    
          RouteSTR.addLoanM: (context) => const MCreateLoan(),
          RouteSTR.loanListM: (context) => const MLoanList(),
    
          RouteSTR.addFdrM: (context) => const MCreateFDR(),
          RouteSTR.fdrListM: (context) => const MFdrList(),
    
          RouteSTR.supportTicketListM: (context) => const MSupportTicketList(),
          RouteSTR.addSupportTicketM: (context) => const MCreateSupportTicket(),
    
          RouteSTR.statsM: (context) => const Stats(),
    
          RouteSTR.upgradeMembershipM: (context) => const MUpgradeMembershipPlan(),
    
          // ADMIN ROUTE(S)
          RouteSTR.dashboardAdmin: (context) => const AdminDashboard(),
    
          // RouteSTR.depositList: (context) => const DepositList(),
          RouteSTR.createDeposit: (context) => const CreateDeposit(),
    
          // RouteSTR.usersList: (context) => const UsersList(),
          RouteSTR.createUsers: (context) => const CreateUsers(),
    
          // RouteSTR.userRoleList: (context) => const UserRoleList(),
          RouteSTR.createUserRole: (context) => const CreateUserRole(),
          RouteSTR.assignRole: (context) => const AssignRole(),
    
          // RouteSTR.permissionList: (context) => const PermissionList(),
          RouteSTR.createPermission: (context) => const CreateUserPermission(),
    
          // RouteSTR.wireTransferList: (context) => const WireTransferList(),
          // RouteSTR.sendMoneyList: (context) => const SendMoneyList(),
          // RouteSTR.exchangeMoneyList: (context) => const ExchangeMoneyList(),
          RouteSTR.createWireTransfer: (context) => const CreateWireTransfer(),
    
          // RouteSTR.loanProductList: (context) => const LoanProductList(),
          RouteSTR.createLoanProduct: (context) => const CreateLoanProduct(),
          RouteSTR.loanCalculator: (context) => const LoanCalculator(),
    
          // RouteSTR.fdrPlanList: (context) => const FdrPlanList(),
          RouteSTR.createPlanFDR: (context) => const CreateFdrPackage(),
    
          // RouteSTR.branchList: (context) => const BranchList(),
          RouteSTR.createBranch: (context) => const CreateBranch(),
    
          // RouteSTR.otherBankList: (context) => const OtherBankList(),
          RouteSTR.createBank: (context) => const CreateOtherBank(),
    
          // RouteSTR.currencyList: (context) => const CurrencyList(),
          RouteSTR.createCurrency: (context) => const CreateCurrency(),
    
          // RouteSTR.serviceList: (context) => const ServiceList(),
          RouteSTR.createService: (context) => const CreateService(),
    
          // RouteSTR.faqList: (context) => const FaqList(),
          RouteSTR.createFaq: (context) => const CreateFaq(),
    
          // RouteSTR.teamList: (context) => const TeamList(),
          RouteSTR.createTeam: (context) => const CreateTeam(),
    
          // RouteSTR.testimonialList: (context) => const TestimonialList(),
          RouteSTR.createTestimonial: (context) => const CreateTestimonial(),
    
          // RouteSTR.navigationList: (context) => const NavigationList(),
          RouteSTR.createNavigation: (context) => const CreateNavigation(),
    
          // RouteSTR.navigationItemList: (context) => const NavigationItemList(),
          RouteSTR.createNavigationItem: (context) => const CreateNavigationItem(),
    
          // RouteSTR.ticketList: (context) => const SupportTicketList(),
          RouteSTR.createTicket: (context) => const CreateSupportTicket(),
          
          // RouteSTR.giftCardList: (context) => const GiftCardList(),
          // RouteSTR.usedGiftCardList: (context) => const UsedGiftCardList(),
          RouteSTR.createGiftCard: (context) => const CreateGiftCard(),
        },
      ),
    ),
  );
}
