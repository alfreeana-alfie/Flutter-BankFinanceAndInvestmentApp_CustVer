import 'package:bank_fvisng_admin/utils/strings.dart';
import 'package:bank_fvisng_admin/utils/styles.dart';
import 'package:bank_fvisng_admin/utils/values.dart';
import 'package:bank_fvisng_admin/widgets/drawerChild.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Styles.secondaryColor,
            ),
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100, 
                  constraints: BoxConstraints(minWidth: 20, maxWidth: 70),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(Values.userPath),
                    minRadius: 20,
                    maxRadius: 50,
                  ),
                ),
                Text('Admin Admin'),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text(Str.dashboardTxt,
              style: GoogleFonts.nunitoSans(
                color: Styles.textColor.withOpacity(1)
              )),
            onTap: () =>
                {Navigator.pushReplacementNamed(context, '/dashboard')},
          ),
          ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            leading: Icon(Icons.people),
            title: Text(UserSTR.usersTxt),
            children: [
              DrawerChild(
                title: UserSTR.allUsersTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/users');
                },
              ),
              DrawerChild(
                title: UserSTR.emailVerifiedTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/email-verified');
                },
              ),
              DrawerChild(
                title: UserSTR.smsVerifiedTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/sms-verified');
                },
              ),
              DrawerChild(
                title: UserSTR.emailUnverifiedTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/email-unverified');
                },
              ),
              DrawerChild(
                title: UserSTR.smsUnverifiedTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/sms-unverified');
                },
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.request_page),
            title: Text(Str.transferRequestTxt,
              style: GoogleFonts.nunitoSans(
                color: Styles.textColor.withOpacity(1)
              )),
            onTap: () => {
              // Navigator.pushNamed(context, '/bottom_nav')
            },
          ),
          ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            leading: Icon(Icons.add),
            title: Text(DepositSTR.depositTxt),
            children: [
              DrawerChild(
                title: DepositSTR.depositRequestTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/deposit-req');
                },
              ),
              DrawerChild(
                title: DepositSTR.makeDepositTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/make-deposit');
                },
              ),
              DrawerChild(
                title: DepositSTR.depositHistoryTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/deposit-hist');
                },
              ),
            ],
          ),
          ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            leading: Icon(Icons.minimize),
            title: Text(WithdrawSTR.withdrawTxt),
            children: [
              DrawerChild(
                title: WithdrawSTR.withdrawRequestTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/withdraw-req');
                },
              ),
              DrawerChild(
                title: WithdrawSTR.makeWithdrawTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/make-withdraw');
                },
              ),
              DrawerChild(
                title: WithdrawSTR.withdrawHistoryTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/withdraw-hist');
                },
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.list_alt),
            title: Text(Str.allTransactionsTxt,
              style: GoogleFonts.nunitoSans(
                color: Styles.textColor.withOpacity(1)
              )),
            onTap: () => {
              // Navigator.pushNamed(context, '/bottom_nav')
            },
          ),
          ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            leading: Icon(Icons.monetization_on),
            title: Text(LoanManagementSTR.loanManagementTxt),
            children: [
              DrawerChild(
                title: LoanManagementSTR.allLoansTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/loans');
                },
              ),
              DrawerChild(
                title: LoanManagementSTR.loanCalculatorTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/loan-cal');
                },
              ),
              DrawerChild(
                title: LoanManagementSTR.addNewLoansTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/add-new-loan');
                },
              ),
              DrawerChild(
                title: LoanManagementSTR.loanProductTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/loan-prod');
                },
              ),
            ],
          ),
          ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            leading: Icon(Icons.money),
            title: Text(FixedDepositSTR.fixedDepositTxt),
            children: [
              DrawerChild(
                title: FixedDepositSTR.allFdrTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/fdr');
                },
              ),
              DrawerChild(
                title: FixedDepositSTR.fdrPackageTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/fdr-package');
                },
              ),
            ],
          ),
          ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            leading: Icon(Icons.card_giftcard),
            title: Text(GiftCardSTR.giftCardTxt),
            children: [
              DrawerChild(
                title: GiftCardSTR.giftCardsTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/gift-cards');
                },
              ),
              DrawerChild(
                title: GiftCardSTR.usedGiftCardTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/used-gift-cards');
                },
              ),
            ],
          ),
          ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            leading: Icon(Icons.support_agent),
            title: Text(SupportTicketSTR.supportTicketTxt),
            children: [
              DrawerChild(
                title: SupportTicketSTR.activeTicketTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/active-ticket');
                },
              ),
              DrawerChild(
                title: SupportTicketSTR.pendingTicketTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/pending-ticket');
                },
              ),
              DrawerChild(
                title: SupportTicketSTR.closedTicketTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/closed-ticket');
                },
              ),
            ],
          ),
          Divider(
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
              'System Settings',
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Styles.textColor.withOpacity(0.5)),
            ),
          ),
          // SYSTEM SETTINGS
          ListTile(
            leading: Icon(Icons.business),
            title: Text(Str.branchTxt,
              style: GoogleFonts.nunitoSans(
                color: Styles.textColor.withOpacity(1)
              )),
            onTap: () => {
              // Navigator.pushNamed(context, '/bottom_nav')
            },
          ),
          ListTile(
            leading: Icon(Icons.business),
            title: Text(Str.otherBankTxt,
              style: GoogleFonts.nunitoSans(
                color: Styles.textColor.withOpacity(1)
              )),
            onTap: () => {
              // Navigator.pushNamed(context, '/bottom_nav')
            },
          ),
          ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            leading: Icon(Icons.people_alt),
            title: Text(SystemUserSTR.systemUsersTxt),
            children: [
              DrawerChild(
                title: SystemUserSTR.allUsersTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/sys-users');
                },
              ),
              DrawerChild(
                title: SystemUserSTR.userRolesTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/user-roles');
                },
              ),
              DrawerChild(
                title: SystemUserSTR.accessControlTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/access-control');
                },
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.money),
            title: Text(
              Str.currencyTxt,
              style: GoogleFonts.nunitoSans(
                color: Styles.textColor.withOpacity(1)
              )),
            onTap: () => {
              // Navigator.pushNamed(context, '/bottom_nav')
            },
          ),
          ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            leading: Icon(Icons.card_membership),
            title: Text(TransactionSettingSTR.transactionSettingsTxt),
            children: [
              DrawerChild(
                title: TransactionSettingSTR.depositMethodTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/trans-deposit-meth');
                },
              ),
              DrawerChild(
                title: TransactionSettingSTR.depositGatewayTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/trans-deposit-gate');
                },
              ),
              DrawerChild(
                title: TransactionSettingSTR.withdrawMethodsTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/trans-withdraw-meth');
                },
              ),
              DrawerChild(
                title: TransactionSettingSTR.transactionsFeeTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/trans-fees');
                },
              ),
            ],
          ),
          ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            leading: Icon(Icons.web),
            title: Text(WebsiteManagementSTR.websiteManagementTxt),
            children: [
              DrawerChild(
                title: WebsiteManagementSTR.faqTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/faq');
                },
              ),
              DrawerChild(
                title: WebsiteManagementSTR.servicesTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/services');
                },
              ),
              DrawerChild(
                title: WebsiteManagementSTR.pagesTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/pages');
                },
              ),
              DrawerChild(
                title: WebsiteManagementSTR.teamsTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/teams');
                },
              ),
              DrawerChild(
                title: WebsiteManagementSTR.testimonialsTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/testimonials');
                },
              ),
              DrawerChild(
                title: WebsiteManagementSTR.themeOptionsTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/theme-opt');
                },
              ),
              DrawerChild(
                title: WebsiteManagementSTR.menuManagementTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/menu-manage');
                },
              ),
            ],
          ),
          ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            leading: Icon(Icons.settings),
            title: Text(AdministrationSTR.administrationTxt),
            children: [
              DrawerChild(
                title: AdministrationSTR.generalSettingTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/general-settings');
                },
              ),
              DrawerChild(
                title: AdministrationSTR.databaseBackupTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/db-backup');
                },
              ),
            ],
          ),
          ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            leading: Icon(Icons.language),
            title: Text(LanguageSTR.languageTxt),
            children: [
              DrawerChild(
                title: LanguageSTR.allLanguageTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/langs');
                },
              ),
              DrawerChild(
                title: LanguageSTR.languageTxt, 
                onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/add-lang');
                },
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.logout_rounded),
            title: Text(Str.signOutTxt,
              style: GoogleFonts.nunitoSans(
                color: Styles.textColor.withOpacity(1)
              )),
            // onTap: () =>
            //     {Navigator.pushReplacementNamed(context, '/SIGN')},
          )
        ],
      ),
    );
  }
}
