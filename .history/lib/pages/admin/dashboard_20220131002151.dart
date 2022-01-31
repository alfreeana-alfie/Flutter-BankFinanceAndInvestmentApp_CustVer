import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/transaction.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/models/wallet_transaction.dart';
import 'package:flutter_banking_app/pages/coming_soon.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/iconly/iconly_bold.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/utils/values.dart';
import 'package:flutter_banking_app/widgets/appbar/app_bar.dart';
import 'package:flutter_banking_app/widgets/left_menu.dart';
import 'package:flutter_banking_app/widgets/transaction_today.dart';
import 'package:flutter_banking_app/widgets/transaction_today_admin.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:oktoast/oktoast.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  SharedPref sharedPref = SharedPref();
  User userLoad = User();
  late Map<String, dynamic> requestMap;
  List<WalletTransaction> transactionList = [];

  loadSharedPrefs() async {
    try {
      User user = User.fromJSON(await sharedPref.read(Pref.userData));
      if (mounted) {
        userLoad = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return OKToast(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(Values.appHeight),
          child: MainAppBar(title: Str.dashboardTxt),
        ),
        drawer: const SideDrawer(),
        backgroundColor: Styles.accentColor,
        body: Container,
        // body: ExpandableTheme(
        //   data: const ExpandableThemeData(
        //     iconColor: Colors.blue,
        //     useInkWell: true,
        //   ),
        //   child: ListView(
        //     physics: const BouncingScrollPhysics(),
        //     children: [
        //       Card1(),
        //     ],
        //   ),
        // ),
      ),
    );
  }

  _innerContainer() {
    return FutureBuilder(
      future: loadSharedPrefs(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Styles.accentColor,
            ),
          );
        } else {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: [
                // Gap(getProportionateScreenHeight(50)),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     InkWell(
                //       child: Container(
                //         padding: const EdgeInsets.all(10),
                //         decoration: const BoxDecoration(
                //           shape: BoxShape.circle,
                //           color: Styles.thirdColor,
                //         ),
                //         child: const Icon(
                //           IconlyBold.Notification,
                //           color: Styles.primaryColor,
                //         ),
                //       ),
                //     )
                //   ],
                // ),
                // const Gap(25),
                // const BalanceBox(),
                // const Gap(20),
                Container(
                  height: 75.0,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Styles.fourthColor,
                  ),
                  child: ListView(
                    // This next line does the trick.
                    scrollDirection: Axis.horizontal,
                    children: [
                      _horizontalSlider(Str.sendMoneyTxt, RouteSTR.sendMoneyM),
                      const Gap(10),
                      _horizontalSlider(
                          Str.exchangeMoneyTxt, RouteSTR.exchangeMoneyM),
                      const Gap(10),
                      _horizontalSlider(
                          Str.wireTransferTxt, RouteSTR.wireTransferM),
                      const Gap(10),
                      _horizontalSlider(
                          Str.newRequestTxt, RouteSTR.addPaymentRequestM),
                      const Gap(10),
                      _horizontalSlider(Str.applyLoanTxt, RouteSTR.addLoanM),
                      const Gap(10),
                      _horizontalSlider(Str.applyDepositTxt, RouteSTR.addFdrM),
                    ],
                  ),
                ),
                const Gap(15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text(
                      'All Transactions',
                      style: TextStyle(
                          color: Styles.textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    // Row(
                    //   children: [
                    //     Text('Today',
                    //         style: TextStyle(
                    //             color: Styles.textColor.withOpacity(0.5),
                    //             fontSize: 16)),
                    //     const Gap(3),
                    //     Icon(CupertinoIcons.chevron_down,
                    //         color: Styles.textColor.withOpacity(0.5), size: 17)
                    //   ],
                    // )
                  ],
                ),
                const TransactionTodayListAdmin()
              ],
            );
          }
        }
      },
    );
  }

  _horizontalSlider(String title, String routeName) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Text(
        title,
        style: const TextStyle(
            color: Styles.accentColor,
            fontWeight: FontWeight.w700,
            fontSize: 14,
            letterSpacing: 0.5),
      ),
      style: ElevatedButton.styleFrom(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(getProportionateScreenWidth(10))),
          primary: Styles.primaryColor),
    );
  }
}
