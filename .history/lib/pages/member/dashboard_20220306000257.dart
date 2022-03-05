import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/iconly/iconly_bold.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/left_menu_member.dart';
import 'package:flutter_banking_app/widgets/transaction_today.dart';
import 'package:gap/gap.dart';

class MemberDashboard extends StatefulWidget {
  const MemberDashboard({Key? key}) : super(key: key);

  @override
  _MemberDashboardState createState() => _MemberDashboardState();
}

class _MemberDashboardState extends State<MemberDasboard> {
  // final GlobalKey<ScaffoldState> _key = GlobalKey();
  SharedPref sharedPref = SharedPref();
  User userLoad = User();

  String? userName;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    // final size = Layouts.getSize(context);
    return Material(
      color: Styles.primaryColor,
      elevation: 0,
      child: Scaffold(
        drawer: const SideDrawerMember(),
        body: _innerContainer(),
      ),
    );
  }

  // @override
  // void initState() {
  //   super.initState();
  // }


  loadSharedPrefs() async {
    try {
      User user = User.fromJSON(await sharedPref.read(Pref.userData));
      if (mounted) {
        userLoad = user;
        userName = user.name;
      }
    } catch (e) {
      print(e);
    }
  }

  _horizontalSlider(String title, String routeName) {
    return ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, routeName);
        },
        child: Text(title, style: const TextStyle(color: Styles.accentColor, fontWeight: FontWeight.w700, fontSize: 14, letterSpacing: 0.5)),
        style: ElevatedButton.styleFrom(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(getProportionateScreenWidth(10))),
            primary: Styles.primaryColor));
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
                Gap(getProportionateScreenHeight(50)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => Scaffold.of(context).openDrawer(),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Styles.transparentColor,
                            ),
                            child: const Icon(
                              Icons.menu,
                              color: Styles.accentColor,
                            ),
                          ),
                        ),
                        const Gap(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Hi $userName',
                                style: const TextStyle(
                                    color: Styles.textColor, fontSize: 16)),
                            const Gap(3),
                            Text(Str.welcomeBack,
                                style: const TextStyle(
                                    color: Styles.textColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      ],
                    ),
                    InkWell(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Styles.thirdColor,
                        ),
                        child: const Icon(
                          IconlyBold.Notification,
                          color: Styles.primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
                // const Gap(25),
                // const BalanceBox(),
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
                      _horizontalSlider(Str.sendMoney, RouteSTR.sendMoneyM),
                      const Gap(10),
                      _horizontalSlider(Str.exchangeMoney, RouteSTR.exchangeMoneyM),
                      const Gap(10),
                      _horizontalSlider(Str.wireTransfer, RouteSTR.wireTransferM),
                      const Gap(10),
                      _horizontalSlider(Str.newRequest, RouteSTR.addPaymentRequestM),
                      const Gap(10),
                      _horizontalSlider(Str.applyLoan, RouteSTR.addLoanM),
                      const Gap(10),
                      _horizontalSlider(Str.applyDeposit, RouteSTR.addFdrM),
                    ],
                  ),
                ),
                const Gap(15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Transactions',
                        style: TextStyle(
                            color: Styles.textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Text('Today',
                            style: TextStyle(
                                color: Styles.textColor.withOpacity(0.5),
                                fontSize: 16)),
                        const Gap(3),
                        Icon(CupertinoIcons.chevron_down,
                            color: Styles.textColor.withOpacity(0.5), size: 17)
                      ],
                    )
                  ],
                ),
                const TransactionTodayList()
              ],
            );
          }
        }
      },
    );
  }
}

// class TransactionTodayList extends StatelessWidget {
//   const TransactionTodayList({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const BouncingScrollPhysics(),
//       itemCount: transactions.length,
//       itemBuilder: (c, i) {
//         final trs = transactions[i];
//         return ListTile(
//           isThreeLine: true,
//           minLeadingWidth: 10,
//           contentPadding: const EdgeInsets.all(0),
//           leading: Container(
//               width: 35,
//               height: 35,
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Styles.primaryWithOpacityColor,
//                 boxShadow: [
//                   BoxShadow(
//                     offset: const Offset(0, 1),
//                     color: Styles.textColor.withOpacity(0.1),
//                     blurRadius: 2,
//                     spreadRadius: 1,
//                   )
//                 ],
//                 image: i == 0
//                     ? null
//                     : DecorationImage(
//                         image: AssetImage(trs['avatar']),
//                         fit: BoxFit.cover,
//                       ),
//                 shape: BoxShape.circle,
//               ),
//               child: i == 0
//                   ? Icon(trs['icon'], color: const Color(0xFFFF736C), size: 20)
//                   : const SizedBox()),
//           title: Text(trs['name'],
//               style: const TextStyle(color: Styles.textColor)),
//           subtitle: Text(trs['date'],
//               style: TextStyle(color: Styles.textColor.withOpacity(0.5))),
//           trailing: Text(trs['amount'],
//               style: const TextStyle(fontSize: 17, color: Styles.textColor)),
//         );
//       },
//     );
//   }
// }
