import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/utils/iconly/iconly_bold.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/utils/values.dart';
import 'package:google_fonts/google_fonts.dart';

import 'drawer_child.dart';

class SideDrawerMember extends StatelessWidget {
  const SideDrawerMember({Key? key}) : super(key: key);

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
                    backgroundImage: AssetImage(Values.userPath),
                    minRadius: 10,
                    maxRadius: 40,
                  ),
                ),
                Text('Admin Admin',
                    style: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Styles.whiteColor)),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: Text(Str.dashboardTxt,
                style: GoogleFonts.nunitoSans(
                    color: Styles.textColor.withOpacity(1))),
            onTap: () =>
                {Navigator.pushNamed(context, RouteSTR.dashboardMember)},
          ),
          ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            leading: const Icon(Icons.send_rounded),
            title: Text(Str.sendMoneyTxt),
            children: [
              DrawerChild(
                title: Str.sendMoneyTxt,
                onNavigate: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, RouteSTR.sendMoneyM);
                  },
              ),
              DrawerChild(
                title: Str.sendMoneyListTxt,
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
            title: Text(Str.exchangeMoneyTxt),
            children: [
              DrawerChild(
                title: Str.exchangeMoneyTxt,
                onNavigate: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, RouteSTR.exchangeMoneyM);
                  },
              ),
              DrawerChild(
                title: Str.exchangeMoneyListTxt,
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
            title: Text(Str.wireTransferTxt),
            children: [
              DrawerChild(
                title: Str.wireTransferTxt,
                onNavigate: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, RouteSTR.wireTransferM);
                  },
              ),
              DrawerChild(
                title: Str.wireTransferListTxt,
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
            title: Text(Str.paymentRequestTxt),
            children: [
              DrawerChild(
                title: Str.newRequestTxt,
                onNavigate: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, RouteSTR.addPaymentRequestM);
                  },
              ),
              DrawerChild(
                title: Str.allRequestTxt,
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
            title: Text(Str.loanTxt),
            children: [
              DrawerChild(
                title: Str.applyLoanTxt,
                onNavigate: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, RouteSTR.addLoanM);
                  },
              ),
              DrawerChild(
                title: Str.myLoanTxt,
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
            title: Text(Str.fixedDepositTxt),
            children: [
              DrawerChild(
                title: Str.applyDepositTxt,
                onNavigate: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, RouteSTR.addFdrM);
                  },
              ),
              DrawerChild(
                title: Str.fdrHistoryTxt,
                onNavigate: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, RouteSTR.fdrListM);
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
              Str.systemSettingsTxt,
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Styles.textColor.withOpacity(0.5)),
            ),
          ),
          // SYSTEM SETTINGS
          ListTile(
            leading: const Icon(Icons.business),
            title: Text(Str.profileOverviewTxt,
                style: GoogleFonts.nunitoSans(
                    color: Styles.textColor.withOpacity(1))),
            onTap: () =>
                {Navigator.pushNamed(context, RouteSTR.profileOverview)},
          ),
          ListTile(
            leading: const Icon(Icons.upgrade),
            title: Text(Str.upgradeTxt,
                style: GoogleFonts.nunitoSans(
                    color: Styles.textColor.withOpacity(1))),
            onTap: () =>
                {Navigator.pushNamed(context, RouteSTR.upgradeMembershipM)},
          ),
          ListTile(
            leading: const Icon(Icons.logout_rounded),
            title: Text(Str.signOutTxt,
                style: GoogleFonts.nunitoSans(
                    color: Styles.textColor.withOpacity(1))),
            onTap: () =>
                {Navigator.pushReplacementNamed(context, RouteSTR.signOut)},
          ),
        ],
      ),
    );
  }
}
