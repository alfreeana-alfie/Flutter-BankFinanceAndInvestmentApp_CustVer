import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/utils/values.dart';
import 'package:google_fonts/google_fonts.dart';

import 'drawer_child.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({Key? key}) : super(key: key);

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
            title: Text('Change to Member Panel',
                style: GoogleFonts.nunitoSans(
                    color: Styles.textColor.withOpacity(1))),
            onTap: () => {
              Navigator.pushReplacementNamed(context, RouteSTR.dashboardMember)
            },
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: Text(Str.dashboardTxt,
                style: GoogleFonts.nunitoSans(
                    color: Styles.textColor.withOpacity(1))),
            onTap: () => {
              Navigator.pushReplacementNamed(context, RouteSTR.dashboardAdmin)
            },
          ),
          ListTile(
            leading: const Icon(Icons.request_page),
            title: Text(Str.depositTxt,
                style: GoogleFonts.nunitoSans(
                    color: Styles.textColor.withOpacity(1))),
            onTap: () => {Navigator.pushNamed(context, RouteSTR.depositList)},
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: Text(Str.usersTxt,
                style: GoogleFonts.nunitoSans(
                    color: Styles.textColor.withOpacity(1))),
            onTap: () => {Navigator.pushNamed(context, RouteSTR.usersList)},
          ),
          ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            leading: const Icon(Icons.transfer_within_a_station),
            title: Text(Str.loanManagementTxt),
            children: [
              DrawerChild(
                title: Str.loanListTxt,
                onNavigate: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, RouteSTR.loanProductList);
                  },
              ),
              DrawerChild(
                title: Str.loanCalculatorTxt,
                onNavigate: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, RouteSTR.comingSoonMenu);
                  },
              ),
            ],
          ),
          ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            leading: const Icon(Icons.money),
            title: Text(Str.fixedDepositTxt),
            children: [
              DrawerChild(
                title: Str.allFdrTxt,
                onNavigate: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, RouteSTR.comingSoonMenu);
                  },
              ),
              DrawerChild(
                title: Str.fdrPackageTxt,
                onNavigate: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, RouteSTR.fdrPlanList);
                  },
              ),
            ],
          ),
          ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            leading: const Icon(Icons.list_alt),
            title: Text(Str.allTransactionsTxt),
            children: [
              DrawerChild(
                title: Str.wireTransferTxt,
                onNavigate: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, RouteSTR.wireTransferList);
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
            title: Text(Str.branchTxt,
                style: GoogleFonts.nunitoSans(
                    color: Styles.textColor.withOpacity(1))),
            onTap: () => {Navigator.pushNamed(context, RouteSTR.branchList)},
          ),
          ListTile(
            leading: const Icon(Icons.business),
            title: Text(Str.otherBankTxt,
                style: GoogleFonts.nunitoSans(
                    color: Styles.textColor.withOpacity(1))),
            onTap: () => {Navigator.pushNamed(context, RouteSTR.otherBankList)},
          ),
          ListTile(
            leading: const Icon(Icons.money),
            title: Text(Str.currencyTxt,
                style: GoogleFonts.nunitoSans(
                    color: Styles.textColor.withOpacity(1))),
            onTap: () => {Navigator.pushNamed(context, RouteSTR.currencyList)},
          ),
          // ExpansionTile(
          //   expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          //   leading: Icon(Icons.card_membership),
          //   title: Text(TransactionSettingSTR.transactionSettingsTxt),
          //   children: [
          //     DrawerChild(
          //       title: TransactionSettingSTR.depositMethodTxt,
          //       onNavigate: TapGestureRecognizer()
          //       ..onTap = () {
          //         Navigator.pushNamed(context, '/trans-deposit-meth');
          //       },
          //     ),
          //     DrawerChild(
          //       title: TransactionSettingSTR.depositGatewayTxt,
          //       onNavigate: TapGestureRecognizer()
          //       ..onTap = () {
          //         Navigator.pushNamed(context, '/trans-deposit-gate');
          //       },
          //     ),
          //     DrawerChild(
          //       title: TransactionSettingSTR.withdrawMethodsTxt,
          //       onNavigate: TapGestureRecognizer()
          //       ..onTap = () {
          //         Navigator.pushNamed(context, '/trans-withdraw-meth');
          //       },
          //     ),
          //     DrawerChild(
          //       title: TransactionSettingSTR.transactionsFeeTxt,
          //       onNavigate: TapGestureRecognizer()
          //       ..onTap = () {
          //         Navigator.pushNamed(context, '/trans-fees');
          //       },
          //     ),
          //   ],
          // ),
          ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            leading: Icon(Icons.web),
            title: Text(Str.websiteManagementTxt),
            children: [
              DrawerChild(
                title: Str.faqTxt,
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, RouteSTR.faqList);
                },
              ),
              DrawerChild(
                title: Str.servicesTxt,
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, RouteSTR.serviceList);
                },
              ),
              // DrawerChild(
              //   title: WebsiteManagementSTR.pagesTxt,
              //   onNavigate: TapGestureRecognizer()
              //   ..onTap = () {
              //     Navigator.pushNamed(context, '/pages');
              //   },
              // ),
              DrawerChild(
                title: Str.teamsTxt,
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, RouteSTR.teamList);
                },
              ),
              DrawerChild(
                title: Str.testimonialsTxt,
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, RouteSTR.testimonialList);
                },
              ),
              // DrawerChild(
              //   title: WebsiteManagementSTR.themeOptionsTxt,
              //   onNavigate: TapGestureRecognizer()
              //   ..onTap = () {
              //     Navigator.pushNamed(context, '/theme-opt');
              //   },
              // ),
              // DrawerChild(
              //   title: WebsiteManagementSTR.menuManagementTxt,
              //   onNavigate: TapGestureRecognizer()
              //   ..onTap = () {
              //     Navigator.pushNamed(context, '/menu-manage');
              //   },
              // ),
            ],
          ),
          // ExpansionTile(
          //   expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          //   leading: Icon(Icons.settings),
          //   title: Text(AdministrationSTR.administrationTxt),
          //   children: [
          //     DrawerChild(
          //       title: AdministrationSTR.generalSettingTxt,
          //       onNavigate: TapGestureRecognizer()
          //       ..onTap = () {
          //         Navigator.pushNamed(context, '/general-settings');
          //       },
          //     ),
          //     DrawerChild(
          //       title: AdministrationSTR.databaseBackupTxt,
          //       onNavigate: TapGestureRecognizer()
          //       ..onTap = () {
          //         Navigator.pushNamed(context, '/db-backup');
          //       },
          //     ),
          //   ],
          // ),
          // ExpansionTile(
          //   expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          //   leading: Icon(Icons.language),
          //   title: Text(LanguageSTR.languageTxt),
          //   children: [
          //     DrawerChild(
          //       title: LanguageSTR.allLanguageTxt,
          //       onNavigate: TapGestureRecognizer()
          //       ..onTap = () {
          //         Navigator.pushNamed(context, '/langs');
          //       },
          //     ),
          //     DrawerChild(
          //       title: LanguageSTR.languageTxt,
          //       onNavigate: TapGestureRecognizer()
          //       ..onTap = () {
          //         Navigator.pushNamed(context, '/add-lang');
          //       },
          //     ),
          //   ],
          // ),
          ListTile(
            leading: const Icon(Icons.logout_rounded),
            title: Text(Str.signOutTxt,
                style: GoogleFonts.nunitoSans(
                    color: Styles.textColor.withOpacity(1))),
            onTap: () => {Navigator.pushReplacementNamed(context, RouteSTR.signIn)},
          ),
        ],
      ),
    );
  }
}
