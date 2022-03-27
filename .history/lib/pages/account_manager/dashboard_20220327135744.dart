import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/models/wallet_transaction.dart';
import 'package:flutter_banking_app/pages/admin/deposit_layout.dart';
import 'package:flutter_banking_app/pages/admin/users_layout.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/utils/values.dart';
import 'package:flutter_banking_app/widgets/appbar/app_bar.dart';
import 'package:flutter_banking_app/widgets/left_menu.dart';
import 'package:flutter_banking_app/widgets/list.dart';
import 'package:flutter_banking_app/widgets/slider_horizontal.dart';
import 'package:flutter_banking_app/widgets/transaction_today.dart';
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
                      HorizontalSlider(
                        title: Str.customerList, 
                        onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CardList(
                              userType: userLoad.userType,
                              type: Type.customer,
                              routePath: Type.nullable,
                              pageName: Str.customerList,
                              path: UsersLayout(
                                type: Field.create,
                                creatorType: userLoad.userType,
                                userLoad: userLoad,
                              ),
                            ),
                          ),
                        );
                      }),
                      const Gap(10),
                      HorizontalSlideAdd(
                        title: Str.registerNewClient,
                        onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => UsersLayout(
                              type: Field.create,
                              userLoad: userLoad,
                            ),
                          ),
                        );
                      }),
                      const Gap(10),
                      HorizontalSlider(
                          title: Str.depositList,
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => CardList(
                                  type: Type.deposit,
                                  routePath: RouteSTR.createDeposit,
                                  pageName: Str.depositList,
                                  path: const DepositLayout(),
                                ),
                              ),
                            );
                          }),
                      const Gap(10),
                      HorizontalSlider(
                          title: Str.withdrawList,
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => CardList(
                                  type: Type.withdraw,
                                  routePath: Type.nullable,
                                  pageName: Str.withdrawList,
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
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
}