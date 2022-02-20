import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/pages/admin/branches/branch_layout.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/utils/values.dart';
import 'package:flutter_banking_app/widgets/list.dart';
import 'package:google_fonts/google_fonts.dart';

import 'drawer_child.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
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
    loadSharedPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: userLoad.userType == Field.admin ? _adminMenu() : _accountant());
  }

  _adminMenu() {
    return ListView(
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
          onTap: () => {
            Navigator.pushReplacementNamed(context, RouteSTR.dashboardAdmin)
          },
        ),
        ExpansionTile(
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          leading: const Icon(Icons.transfer_within_a_station),
          title: Text(Str.deposit),
          children: [
            DrawerChild(
              title: Str.depositList,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  // Navigator.pushNamed(context, RouteSTR.depositList);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CardList(
                        type: Type.deposit,
                        routePath: RouteSTR.createDeposit,
                        pageName: Str.depositList,
                      ),
                    ),
                  );
                },
            ),
            DrawerChild(
              title: Str.createDeposit,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, RouteSTR.createDeposit);
                },
            ),
          ],
        ),
        ExpansionTile(
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          leading: const Icon(Icons.transfer_within_a_station),
          title: Text(Str.withdraw),
          children: [
            DrawerChild(
              title: Str.withdrawList,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  // Navigator.pushNamed(context, RouteSTR.depositList);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CardList(
                        type: Type.withdraw,
                        routePath: Type.nullable,
                        pageName: Str.withdrawList,
                      ),
                    ),
                  );
                },
            ),
            // DrawerChild(
            //   title: Str.createDeposit,
            //   onNavigate: TapGestureRecognizer()
            //     ..onTap = () {
            //       Navigator.pushNamed(context, RouteSTR.createDeposit);
            //     },
            // ),
          ],
        ),
        ExpansionTile(
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          leading: const Icon(Icons.transfer_within_a_station),
          title: Text(Str.users),
          children: [
            DrawerChild(
              title: Str.userList,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  // Navigator.pushNamed(context, RouteSTR.usersList);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CardList(
                        type: Type.userList,
                        routePath: RouteSTR.createUsers,
                        pageName: Str.usersList,
                      ),
                    ),
                  );
                },
            ),
            DrawerChild(
              title: Str.createUser,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, RouteSTR.createUsers);
                },
            ),
            DrawerChild(
              title: Str.userRoleList,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  // Navigator.pushNamed(context, RouteSTR.userRoleList);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CardList(
                        type: Type.userRole,
                        routePath: RouteSTR.createUserRole,
                        pageName: Str.userRoleList,
                      ),
                    ),
                  );
                },
            ),
            DrawerChild(
              title: Str.createUserRole,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, RouteSTR.createUserRole);
                },
            ),
            DrawerChild(
              title: Str.assignRole,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, RouteSTR.assignRole);
                },
            ),
            DrawerChild(
              title: Str.permissionList,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  // Navigator.pushNamed(context, RouteSTR.permissionList);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CardList(
                        type: Type.userPermission,
                        routePath: RouteSTR.createPermission,
                        pageName: Str.permissionList,
                      ),
                    ),
                  );
                },
            ),
            DrawerChild(
              title: Str.createPermission,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, RouteSTR.createPermission);
                },
            ),
          ],
        ),
        ExpansionTile(
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          leading: const Icon(Icons.transfer_within_a_station),
          title: Text(Str.loanManagement),
          children: [
            DrawerChild(
              title: Str.createLoanProduct,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, RouteSTR.createLoanProduct);
                },
            ),
            DrawerChild(
              title: Str.loanProductList,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  // Navigator.pushNamed(context, RouteSTR.loanProductList);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CardList(
                          type: Type.loanProduct,
                          routePath: RouteSTR.createLoanProduct,
                          pageName: Str.loanProductList),
                    ),
                  );
                },
            ),
            DrawerChild(
              title: Str.loanCalculator,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, RouteSTR.loanCalculator);
                },
            ),
          ],
        ),
        ExpansionTile(
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          leading: const Icon(Icons.money),
          title: Text(Str.fixedDeposit),
          children: [
            DrawerChild(
              title: Str.allFdr,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  // Navigator.pushNamed(context, RouteSTR.fdrPlanList);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CardList(
                        type: Type.fdrPlan,
                        routePath: RouteSTR.createPlanFDR,
                        pageName: Str.fdrPlanList,
                      ),
                    ),
                  );
                },
            ),
            DrawerChild(
              title: Str.createFdrPlan,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, RouteSTR.createPlanFDR);
                },
            ),
          ],
        ),
        ExpansionTile(
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          leading: const Icon(Icons.list_alt),
          title: Text(Str.allTransactions),
          children: [
            DrawerChild(
              title: 'Wallet Transaction(s) List',
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  // Navigator.pushNamed(
                  //     context, RouteSTR.walletTransactionList);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CardList(
                        type: Type.walletTransaction,
                        routePath: Type.nullable,
                        pageName: Str.allTransactions,
                      ),
                    ),
                  );
                },
            ),
            // DrawerChild(
            //   title: Str.wireTransfer,
            //   onNavigate: TapGestureRecognizer()
            //     ..onTap = () {
            //       Navigator.pushNamed(context, RouteSTR.createWireTransfer);
            //     },
            // ),
            DrawerChild(
              title: Str.wireTransferList,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  // Navigator.pushNamed(context, RouteSTR.wireTransferList);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CardList(
                        type: Type.wireTransfer,
                        routePath: Type.nullable,
                        pageName: Str.wireTransferList,
                      ),
                    ),
                  );
                },
            ),
            DrawerChild(
              title: Str.sendMoneyList,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  // Navigator.pushNamed(context, RouteSTR.sendMoneyList);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CardList(
                        type: Type.sendMoney,
                        routePath: Type.nullable,
                        pageName: Str.sendMoneyList,
                      ),
                    ),
                  );
                },
            ),
            DrawerChild(
              title: Str.exchangeMoneyList,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  // Navigator.pushNamed(context, RouteSTR.exchangeMoneyList);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CardList(
                        type: Type.exchangeMoney,
                        routePath: Type.nullable,
                        pageName: Str.exchangeMoneyList,
                      ),
                    ),
                  );
                },
            ),
          ],
        ),
        ExpansionTile(
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          leading: const Icon(Icons.card_giftcard),
          title: Text(Str.giftCard),
          children: [
            DrawerChild(
              title: Str.giftCardList,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  // Navigator.pushNamed(context, RouteSTR.giftCardList);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CardList(
                        type: Type.giftCard,
                        routePath: RouteSTR.createGiftCard,
                        pageName: Str.giftCardList,
                      ),
                    ),
                  );
                },
            ),
            DrawerChild(
              title: Str.usedGiftCardList,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  // Navigator.pushNamed(context, RouteSTR.usedGiftCardList);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CardList(
                        type: Type.giftCardUsed,
                        routePath: Type.nullable,
                        pageName: Str.usedGiftCardList,
                      ),
                    ),
                  );
                },
            ),
            DrawerChild(
              title: Str.createGiftCard,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, RouteSTR.createGiftCard);
                },
            ),
          ],
        ),
        ExpansionTile(
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          leading: const Icon(Icons.support_agent),
          title: Text(Str.supportTicket),
          children: [
            DrawerChild(
              title: Str.supportTicketList,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  // Navigator.pushNamed(context, RouteSTR.ticketList);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CardList(
                        type: Type.ticket,
                        routePath: RouteSTR.createTicket,
                        pageName: Str.supportTicketList,
                      ),
                    ),
                  );
                },
            ),
            DrawerChild(
              title: Str.createTicket,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, RouteSTR.createTicket);
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
        ExpansionTile(
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          leading: const Icon(Icons.business),
          title: Text(Str.branch),
          children: [
            DrawerChild(
              title: Str.branchList,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CardList(
                        type: Type.branch,
                        routePath: RouteSTR.createBranch,
                        pageName: Str.branchList,
                        path: BranchLayout(
                          type: Field.create,
                        ),
                      ),
                    ),
                  );
                },
            ),
            DrawerChild(
              title: Str.createBranch,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BranchLayout(
                        type: Field.create,
                      ),
                    ),
                  );
                },
            ),
          ],
        ),
        ExpansionTile(
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          leading: const Icon(Icons.attach_money),
          title: Text(Str.rate),
          children: [
            DrawerChild(
              title: Str.rateList,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  // Navigator.pushNamed(context, RouteSTR.rateList);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CardList(
                        type: Type.rate,
                        routePath: Type.nullable,
                        pageName: Str.rateList,
                      ),
                    ),
                  );
                },
            ),
          ],
        ),
        ExpansionTile(
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          leading: const Icon(Icons.other_houses),
          title: Text(Str.otherBank),
          children: [
            DrawerChild(
              title: Str.otherBankList,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  // Navigator.pushNamed(context, RouteSTR.otherBankList);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CardList(
                        type: Type.otherBank,
                        routePath: RouteSTR.createBank,
                        pageName: Str.otherBankList,
                      ),
                    ),
                  );
                },
            ),
            DrawerChild(
              title: Str.createOtherBank,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, RouteSTR.createBank);
                },
            ),
          ],
        ),
        ExpansionTile(
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          leading: const Icon(Icons.money),
          title: Text(Str.currency),
          children: [
            DrawerChild(
              title: Str.currencyList,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  // Navigator.pushNamed(context, RouteSTR.currencyList);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CardList(
                        type: Type.currency,
                        routePath: RouteSTR.createCurrency,
                        pageName: Str.currencyList,
                      ),
                    ),
                  );
                },
            ),
            DrawerChild(
              title: Str.createCurrency,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, RouteSTR.createCurrency);
                },
            ),
          ],
        ),
        ExpansionTile(
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          leading: const Icon(Icons.web_sharp),
          title: Text(Str.websiteManagement),
          children: [
            DrawerChild(
              title: Str.faqList,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  // Navigator.pushNamed(context, RouteSTR.faqList);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CardList(
                        type: Type.faq,
                        routePath: RouteSTR.createFaq,
                        pageName: Str.faqList,
                      ),
                    ),
                  );
                },
            ),
            DrawerChild(
              title: Str.createFaq,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, RouteSTR.createFaq);
                },
            ),
            // Navigation
            DrawerChild(
              title: Str.navigationList,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  // Navigator.pushNamed(context, RouteSTR.navigationList);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CardList(
                        type: Type.navigation,
                        routePath: RouteSTR.createNavigation,
                        pageName: Str.navigationList,
                      ),
                    ),
                  );
                },
            ),
            DrawerChild(
              title: Str.createNavigation,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, RouteSTR.createNavigation);
                },
            ),
            // Navigation Item
            DrawerChild(
              title: Str.navigationItemList,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  // Navigator.pushNamed(context, RouteSTR.navigationItemList);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CardList(
                        type: Type.navigationItem,
                        routePath: RouteSTR.createNavigationItem,
                        pageName: Str.navigationItemList,
                      ),
                    ),
                  );
                },
            ),
            DrawerChild(
              title: Str.createNavigationItem,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, RouteSTR.createNavigationItem);
                },
            ),
            // Services
            DrawerChild(
              title: Str.serviceList,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  // Navigator.pushNamed(context, RouteSTR.serviceList);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CardList(
                        type: Type.service,
                        routePath: RouteSTR.createService,
                        pageName: Str.serviceList,
                      ),
                    ),
                  );
                },
            ),
            DrawerChild(
              title: Str.createService,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, RouteSTR.createService);
                },
            ),
            // Team
            DrawerChild(
              title: Str.teamList,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  // Navigator.pushNamed(context, RouteSTR.teamList);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CardList(
                        type: Type.team,
                        routePath: RouteSTR.createTeam,
                        pageName: Str.teamList,
                      ),
                    ),
                  );
                },
            ),
            DrawerChild(
              title: Str.createTeam,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, RouteSTR.createTeam);
                },
            ),
            // Testimonial
            DrawerChild(
              title: Str.testimonialList,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  // Navigator.pushNamed(context, RouteSTR.testimonialList);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CardList(
                        type: Type.testimonial,
                        routePath: RouteSTR.createTestimonial,
                        pageName: Str.testimonialList,
                      ),
                    ),
                  );
                },
            ),
            DrawerChild(
              title: Str.createTestimonial,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, RouteSTR.createTestimonial);
                },
            ),
          ],
        ),
        // SYSTEM SETTINGS
        ListTile(
          leading: const Icon(Icons.manage_accounts),
          title: Text(Str.profileOverview,
              style: GoogleFonts.nunitoSans(
                  color: Styles.textColor.withOpacity(1))),
          onTap: () => {Navigator.pushNamed(context, RouteSTR.profileOverview)},
        ),
        ListTile(
          leading: const Icon(Icons.logout_rounded),
          title: Text(Str.signOut,
              style: GoogleFonts.nunitoSans(
                  color: Styles.textColor.withOpacity(1))),
          onTap: () {
            sharedPref.remove(Pref.expiredAt);
            sharedPref.remove(Pref.accessToken);
            sharedPref.remove(Pref.userData);
            Navigator.pushReplacementNamed(context, RouteSTR.signIn);
          },
        ),
      ],
    );
  }

  _accountant() {
    return ListView(
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
          onTap: () => {
            Navigator.pushReplacementNamed(
                context, RouteSTR.dashboardAccountant)
          },
        ),
        ExpansionTile(
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          leading: const Icon(Icons.transfer_within_a_station),
          title: Text(Str.customer),
          children: [
            DrawerChild(
              title: Str.customerList,
              onNavigate: TapGestureRecognizer()
                ..onTap = () {
                  // Navigator.pushNamed(context, RouteSTR.usersList);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CardList(
                        type: Type.customer,
                        routePath: Type.nullable,
                        pageName: Str.customerList,
                      ),
                    ),
                  );
                },
            ),
          ],
        ),
        // ExpansionTile(
        //   expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
        //   leading: const Icon(Icons.list_alt),
        //   title: Text(Str.allTransactions),
        //   children: [
        //     DrawerChild(
        //       title: 'Wallet Transaction(s) List',
        //       onNavigate: TapGestureRecognizer()
        //         ..onTap = () {
        //           // Navigator.pushNamed(
        //           //     context, RouteSTR.walletTransactionList);
        //           Navigator.of(context).push(
        //             MaterialPageRoute(
        //               builder: (context) => CardList(
        //                 type: Type.walletTransaction,
        //                 routePath: Type.nullable,
        //                 pageName: Str.allTransactions,
        //               ),
        //             ),
        //           );
        //         },
        //     ),
        //   ],
        // ),
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
          leading: const Icon(Icons.manage_accounts),
          title: Text(Str.profileOverview,
              style: GoogleFonts.nunitoSans(
                  color: Styles.textColor.withOpacity(1))),
          onTap: () => {Navigator.pushNamed(context, RouteSTR.profileOverview)},
        ),
        ListTile(
          leading: const Icon(Icons.logout_rounded),
          title: Text(Str.signOut,
              style: GoogleFonts.nunitoSans(
                  color: Styles.textColor.withOpacity(1))),
          onTap: () =>
              {Navigator.pushReplacementNamed(context, RouteSTR.signOut)},
        ),
      ],
    );
  }
}
