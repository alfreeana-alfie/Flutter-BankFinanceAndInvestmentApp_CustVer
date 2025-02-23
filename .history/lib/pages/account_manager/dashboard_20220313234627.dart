import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/models/wallet_transaction.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/utils/values.dart';
import 'package:flutter_banking_app/widgets/appbar/app_bar.dart';
import 'package:flutter_banking_app/widgets/left_menu.dart';
import 'package:flutter_banking_app/widgets/list.dart';
import 'package:flutter_banking_app/widgets/transaction_today_accountant.dart';
import 'package:flutter_banking_app/widgets/transaction_today_admin.dart';
import 'package:gap/gap.dart';

class AccountManagementDashboard extends StatefulWidget {
  const AccountManagementDashboard({Key? key}) : super(key: key);

  @override
  _AccountManagementDashboardState createState() =>
      _AccountManagementDashboardState();
}

class _AccountManagementDashboardState
    extends State<AccountManagementDashboard> {
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

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(Values.appHeight),
        child: MainAppBar(title: Str.dashboard),
      ),
      drawer: const SideDrawer(),
      backgroundColor: Styles.accentColor,
      body: Container(color: Styles.whiteColor, child: _innerContainer()),
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
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      Str.transactionHistory,
                      style: TextStyle(
                          color: Styles.textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
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


  _horizontalSlider(String title, void Function()? onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
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

  _horizontalSliderAdd(String title, void Function()? onPressed) {
    return ElevatedButton(
      onPressed: onPressed,,
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
