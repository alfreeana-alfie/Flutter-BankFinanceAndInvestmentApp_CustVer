import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/utils/values.dart';
import 'package:google_fonts/google_fonts.dart';

import 'drawer_child.dart';

// class SideDrawerMember extends StatelessWidget {
//   const SideDrawerMember({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           DrawerHeader(
//             decoration: const BoxDecoration(
//               color: Styles.accentColor,
//             ),
//             child: Column(
//               children: [
//                 Container(
//                   width: 100,
//                   height: 100,
//                   constraints: const BoxConstraints(minWidth: 20, maxWidth: 70),
//                   child: CircleAvatar(
//                     backgroundImage: AssetImage(Values.userPath),
//                     minRadius: 10,
//                     maxRadius: 40,
//                   ),
//                 ),
//                 Text('Admin Admin',
//                     style: GoogleFonts.nunito(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                         color: Styles.whiteColor)),
//               ],
//             ),
//           ),
//           ListTile(
//             leading: const Icon(Icons.dashboard),
//             title: Text(Str.dashboard,
//                 style: GoogleFonts.nunitoSans(
//                     color: Styles.textColor.withOpacity(1))),
//             onTap: () =>
//                 {Navigator.pushNamed(context, RouteSTR.dashboardMember)},
//           ),
//           ExpansionTile(
//             expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
//             leading: const Icon(Icons.send_rounded),
//             title: Text(Str.sendMoney),
//             children: [
//               DrawerChild(
//                 title: Str.sendMoney,
//                 onNavigate: TapGestureRecognizer()
//                   ..onTap = () {
//                     Navigator.pushNamed(context, RouteSTR.sendMoneyM);
//                   },
//               ),
//               DrawerChild(
//                 title: Str.sendMoneyList,
//                 onNavigate: TapGestureRecognizer()
//                   ..onTap = () {
//                     Navigator.pushNamed(context, RouteSTR.sendMoneyListM);
//                   },
//               ),
//             ],
//           ),
//           ExpansionTile(
//             expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
//             leading: const Icon(Icons.change_circle),
//             title: Text(Str.exchangeMoney),
//             children: [
//               DrawerChild(
//                 title: Str.exchangeMoney,
//                 onNavigate: TapGestureRecognizer()
//                   ..onTap = () {
//                     Navigator.pushNamed(context, RouteSTR.exchangeMoneyM);
//                   },
//               ),
//               DrawerChild(
//                 title: Str.exchangeMoneyList,
//                 onNavigate: TapGestureRecognizer()
//                   ..onTap = () {
//                     Navigator.pushNamed(context, RouteSTR.exchangeMoneyListM);
//                   },
//               ),
//             ],
//           ),
//           ExpansionTile(
//             expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
//             leading: const Icon(Icons.swap_horizontal_circle),
//             title: Text(Str.wireTransfer),
//             children: [
//               DrawerChild(
//                 title: Str.wireTransfer,
//                 onNavigate: TapGestureRecognizer()
//                   ..onTap = () {
//                     Navigator.pushNamed(context, RouteSTR.wireTransferM);
//                   },
//               ),
//               DrawerChild(
//                 title: Str.wireTransferList,
//                 onNavigate: TapGestureRecognizer()
//                   ..onTap = () {
//                     Navigator.pushNamed(context, RouteSTR.wireTransferListM);
//                   },
//               ),
//             ],
//           ),
//           ExpansionTile(
//             expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
//             leading: const Icon(Icons.request_page),
//             title: Text(Str.paymentRequest),
//             children: [
//               DrawerChild(
//                 title: Str.newRequest,
//                 onNavigate: TapGestureRecognizer()
//                   ..onTap = () {
//                     Navigator.pushNamed(context, RouteSTR.addPaymentRequestM);
//                   },
//               ),
//               DrawerChild(
//                 title: Str.allRequest,
//                 onNavigate: TapGestureRecognizer()
//                   ..onTap = () {
//                     Navigator.pushNamed(context, RouteSTR.paymentRequestM);
//                   },
//               ),
//             ],
//           ),
//           ExpansionTile(
//             expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
//             leading: const Icon(Icons.receipt),
//             title: Text(Str.loan),
//             children: [
//               DrawerChild(
//                 title: Str.applyLoan,
//                 onNavigate: TapGestureRecognizer()
//                   ..onTap = () {
//                     Navigator.pushNamed(context, RouteSTR.addLoanM);
//                   },
//               ),
//               DrawerChild(
//                 title: Str.myLoan,
//                 onNavigate: TapGestureRecognizer()
//                   ..onTap = () {
//                     Navigator.pushNamed(context, RouteSTR.loanListM);
//                   },
//               ),
//             ],
//           ),
//           ExpansionTile(
//             expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
//             leading: const Icon(Icons.local_atm_rounded),
//             title: Text(Str.fixedDeposit),
//             children: [
//               DrawerChild(
//                 title: Str.applyDeposit,
//                 onNavigate: TapGestureRecognizer()
//                   ..onTap = () {
//                     Navigator.pushNamed(context, RouteSTR.addFdrM);
//                   },
//               ),
//               DrawerChild(
//                 title: Str.fdrHistory,
//                 onNavigate: TapGestureRecognizer()
//                   ..onTap = () {
//                     Navigator.pushNamed(context, RouteSTR.fdrListM);
//                   },
//               ),
//             ],
//           ),
//           const Divider(
//             indent: 10,
//             endIndent: 10,
//             height: 1,
//             thickness: 1,
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(
//                 horizontal: Values.horizontalValue * 2,
//                 vertical: Values.verticalValue),
//             child: Text(
//               Str.systemSettings,
//               style: GoogleFonts.nunitoSans(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                   color: Styles.textColor.withOpacity(0.5)),
//             ),
//           ),
//           // SYSTEM SETTINGS
//           ListTile(
//             leading: const Icon(Icons.business),
//             title: Text(Str.profileOverview,
//                 style: GoogleFonts.nunitoSans(
//                     color: Styles.textColor.withOpacity(1))),
//             onTap: () =>
//                 {Navigator.pushNamed(context, RouteSTR.profileOverview)},
//           ),
//           ListTile(
//             leading: const Icon(Icons.upgrade),
//             title: Text(Str.upgrade,
//                 style: GoogleFonts.nunitoSans(
//                     color: Styles.textColor.withOpacity(1))),
//             onTap: () =>
//                 {Navigator.pushNamed(context, RouteSTR.upgradeMembershipM)},
//           ),
//           ListTile(
//             leading: const Icon(Icons.logout_rounded),
//             title: Text(Str.signOut,
//                 style: GoogleFonts.nunitoSans(
//                     color: Styles.textColor.withOpacity(1))),
//             onTap: () =>
//                 {Navigator.pushReplacementNamed(context, RouteSTR.signOut)},
//           ),
//         ],
//       ),
//     );
//   }
// }

class SideDrawerMember extends StatefulWidget {
  const SideDrawerMember({ Key? key }) : super(key: key);

  @override
  _SideDrawerMemberState createState() => _SideDrawerMemberState();
}

class _SideDrawerMemberState extends State<SideDrawerMember> {
  SharedPref sharedPref = SharedPref();
  User userLoad = User();

  loadSharedPrefs() async {
    try {
      User user = User.fromJSON(await sharedPref.read(Pref.userData));
      setState(() {
        userLoad = user;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    loadSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Styles.accentColor,
            ),
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  constraints: const BoxConstraints(minWidth: 20, maxWidth: 70),
                  child: CircleAvatar(
                    // backgroundImage: AssetImage(Values.userPath),
                    backgroundImage: NetworkImage(Values.userDefaultImage),
                    minRadius: 10,
                    maxRadius: 40,
                  ),
                ),
                Text(userLoad.name ?? 'User',
                    style: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Styles.whiteColor)),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: Text(Str.dashboard,
                style: GoogleFonts.nunitoSans(
                    color: Styles.textColor.withOpacity(1))),
            onTap: () =>
                {Navigator.pushNamed(context, RouteSTR.dashboardMember)},
          ),
          ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            leading: const Icon(Icons.send_rounded),
            title: Text(Str.sendMoney),
            children: [
              DrawerChild(
                title: Str.sendMoney,
                onNavigate: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, RouteSTR.sendMoneyM);
                  },
              ),
              DrawerChild(
                title: Str.sendMoneyList,
                onNavigate: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, RouteSTR.sendMoneyListM);
                  },
              ),
            ],
          ),
          ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            leading: const Icon(Icons.change_circle),
            title: Text(Str.exchangeMoney),
            children: [
              DrawerChild(
                title: Str.exchangeMoney,
                onNavigate: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, RouteSTR.exchangeMoneyM);
                  },
              ),
              DrawerChild(
                title: Str.exchangeMoneyList,
                onNavigate: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, RouteSTR.exchangeMoneyListM);
                  },
              ),
            ],
          ),
          ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            leading: const Icon(Icons.swap_horizontal_circle),
            title: Text(Str.wireTransfer),
            children: [
              DrawerChild(
                title: Str.wireTransfer,
                onNavigate: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, RouteSTR.wireTransferM);
                  },
              ),
              DrawerChild(
                title: Str.wireTransferList,
                onNavigate: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, RouteSTR.wireTransferListM);
                  },
              ),
            ],
          ),
          ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            leading: const Icon(Icons.request_page),
            title: Text(Str.paymentRequest),
            children: [
              DrawerChild(
                title: Str.newRequest,
                onNavigate: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, RouteSTR.addPaymentRequestM);
                  },
              ),
              DrawerChild(
                title: Str.allRequest,
                onNavigate: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, RouteSTR.paymentRequestM);
                  },
              ),
            ],
          ),
          ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            leading: const Icon(Icons.receipt),
            title: Text(Str.loan),
            children: [
              DrawerChild(
                title: Str.applyLoan,
                onNavigate: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, RouteSTR.addLoanM);
                  },
              ),
              DrawerChild(
                title: Str.myLoan,
                onNavigate: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, RouteSTR.loanListM);
                  },
              ),
            ],
          ),
          ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            leading: const Icon(Icons.local_atm_rounded),
            title: Text(Str.fixedDeposit),
            children: [
              DrawerChild(
                title: Str.applyDeposit,
                onNavigate: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, RouteSTR.addFdrM);
                  },
              ),
              DrawerChild(
                title: Str.fdrHistory,
                onNavigate: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, RouteSTR.fdrListM);
                  },
              ),
            ],
          ),
          ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            leading: const Icon(Icons.send_rounded),
            title: Text(Str.withdraw),
            children: [
              DrawerChild(
                title: Str.withdrawList,
                onNavigate: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, RouteSTR.withdrawListM);
                  },
              ),
              DrawerChild(
                title: Str.createWithdraw,
                onNavigate: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, RouteSTR.createWithdraw);
                  },
              ),
            ],
          ),
          const Divider(
            indent: 10,
            endIndent: 10,
            height: 1,
            thickness: 1,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: Values.horizontalValue * 2,
                vertical: Values.verticalValue),
            child: Text(
              Str.systemSettings,
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Styles.textColor.withOpacity(0.5)),
            ),
          ),
          // SYSTEM SETTINGS
          ListTile(
            leading: const Icon(Icons.business),
            title: Text(Str.profileOverview,
                style: GoogleFonts.nunitoSans(
                    color: Styles.textColor.withOpacity(1))),
            onTap: () =>
                {Navigator.pushNamed(context, RouteSTR.profileOverview)},
          ),
          ListTile(
            leading: const Icon(Icons.upgrade),
            title: Text(Str.upgrade,
                style: GoogleFonts.nunitoSans(
                    color: Styles.textColor.withOpacity(1))),
            onTap: () =>
                {Navigator.pushNamed(context, RouteSTR.upgradeMembershipM)},
          ),
          ListTile(
            leading: const Icon(Icons.logout_rounded),
            title: Text(Str.signOut,
                style: GoogleFonts.nunitoSans(
                    color: Styles.textColor.withOpacity(1))),
            onTap: () =>
                {
                  sharedPref.remove(Pref.expiredAt);
            sharedPref.remove(Pref.accessToken);
            sharedPref.remove(Pref.userData);
            Navigator.pushReplacementNamed(context, RouteSTR.signIn);
                },
          ),
        ],
      ),
    );
  }
}
