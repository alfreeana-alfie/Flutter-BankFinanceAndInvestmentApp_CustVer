import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/bank.dart';
import 'package:flutter_banking_app/models/branch.dart';
import 'package:flutter_banking_app/models/currency.dart';
import 'package:flutter_banking_app/models/fdr_plan.dart';
import 'package:flutter_banking_app/models/membership.dart';
import 'package:flutter_banking_app/models/navigation.dart';
import 'package:flutter_banking_app/models/role.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/models/user_wallet.dart';
import 'package:flutter_banking_app/models/users.dart';
import 'package:flutter_banking_app/models/wallet.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:http/http.dart' as http;

// ?? DROPDOWN ACCOUNT
class DropDownAccount extends StatefulWidget {
  const DropDownAccount(
      {Key? key,
      this.account,
      this.accountName,
      this.accountBalance,
      this.walletId,
      required this.onChanged})
      : super(key: key);

  final String? account, accountName, accountBalance, walletId;
  final void Function(Wallet?) onChanged;

  @override
  _DropDownAccountState createState() => _DropDownAccountState();
}

class _DropDownAccountState extends State<DropDownAccount> {
  List<Wallet> planListNew = [];
  SharedPref sharedPref = SharedPref();
  User userLoad = User();

  Future view() async {
    User user = User.fromJSON(await sharedPref.read(Pref.userData));
    String userId = user.id.toString();
    Uri viewSingleUser = Uri.parse(API.listOfWallet.toString() + userId);
    final response = await http.get(viewSingleUser, headers: headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);
      for (var req in jsonBody[Field.data]) {
        final data = Wallet.fromMap(req);
        setState(() {
          planListNew.add(data);
        });
      }
    } else {
      print(Status.failed);
      CustomToast.showMsg(Status.failed, Styles.dangerColor);
    }
  }

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
    view();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _dropDownSearch();
  }

  _dropDownSearch() {
    return DropdownSearch<Wallet>(
      mode: Mode.DIALOG,
      showSearchBox: true,
      onChanged: widget.onChanged,
      onFind: (String? filter) => getData(filter),
      itemAsString: (planListNew) {
        return '${planListNew!.description} - NGN ${double.parse(planListNew.amount!).toStringAsFixed(2)}';
      },
      dropdownSearchDecoration: InputDecoration(
        hintText: Str.selectAccount,
        filled: true,
        fillColor: Colors.black12.withOpacity(0.05),
        contentPadding: const EdgeInsets.fromLTRB(15, 12, 0, 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Future<List<Wallet>> getData(filter) async {
    return planListNew;
  }
}

// ?? DROPDOWN BANK
class DropDownBank extends StatefulWidget {
  const DropDownBank(
      {Key? key,
      this.bank,
      this.bankName,
      this.swiftCode,
      required this.onChanged})
      : super(key: key);

  final String? bank, bankName, swiftCode;
  final void Function(Bank?) onChanged;

  @override
  _DropDownBankState createState() => _DropDownBankState();
}

class _DropDownBankState extends State<DropDownBank> {
  List<Bank> planListNew = [];

  void getCurrency() async {
    final response = await http.get(AdminAPI.listOfOtherBank, headers: headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);

      for (var plan in jsonBody[Field.data]) {
        final plans = Bank.fromMap(plan);

        setState(() {
          planListNew.add(plans);
        });
      }
    } else {
      print(Status.failed);
    }
  }

  @override
  void initState() {
    getCurrency();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
    //   decoration: BoxDecoration(
    //     color: Colors.black12.withOpacity(0.05),
    //     borderRadius: BorderRadius.circular(15.0),
    //   ),
    //   child: DropdownButtonHideUnderline(
    //     child: DropdownButton(
    //       dropdownColor: Styles.greyColor,
    //       icon: const RotatedBox(
    //           quarterTurns: 3,
    //           child: Icon(
    //             Icons.chevron_left,
    //             size: 20,
    //             color: Styles.textColor,
    //           )),
    //       hint: widget.bankName == null
    //           ? Text(Str.bank, style: Styles.primaryTitle)
    //           : Text(
    //               widget.bankName!,
    //               style: Styles.primaryTitle,
    //             ),
    //       isExpanded: true,
    //       iconSize: 30.0,
    //       style: Styles.primaryTitle,
    //       items: planListNew.map(
    //         (val) {
    //           return DropdownMenuItem<Bank>(
    //             value: val,
    //             child: Text(val.name ?? '-'),
    //           );
    //         },
    //       ).toList(),
    //       onChanged: widget.onChanged,
    //     ),
    //   ),
    // );
    return _dropDownSearch();
  }

  _dropDownSearch() {
    return DropdownSearch<Bank>(
      showSearchBox: true,
      onChanged: widget.onChanged,
      onFind: (String? filter) => getData(filter),
      itemAsString: (items) {
        return items!.name ?? Field.empty;
      },
      dropdownSearchDecoration: InputDecoration(
        hintText: Str.selectBank,
        filled: true,
        fillColor: Colors.black12.withOpacity(0.05),
        contentPadding: const EdgeInsets.fromLTRB(15, 12, 0, 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Future<List<Bank>> getData(filter) async {
    return planListNew;
  }
}

// ?? DROPDOWN BRANCHES
class DropDownBranches extends StatefulWidget {
  const DropDownBranches(
      {Key? key,
      this.branch,
      this.branchName,
      // required this.currencyList,
      required this.onChanged})
      : super(key: key);

  final String? branch, branchName;
  final void Function(Branch?) onChanged;
  // final List<Currency> currencyList;

  @override
  _DropDownBranchesState createState() => _DropDownBranchesState();
}

class _DropDownBranchesState extends State<DropDownBranches> {
  List<Branch> currencyListNew = [];

  void getCurrency() async {
    final response = await http.get(AdminAPI.listOfBranch, headers: headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);

      for (var currency in jsonBody[Field.data]) {
        final currencies = Branch.fromMap(currency);

        setState(() {
          currencyListNew.add(currencies);
        });
      }
    } else {
      print(Status.failed);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrency();
  }

  @override
  Widget build(BuildContext context) {
    return _dropDownSearch();
  }

  _dropDownSearch() {
    return DropdownSearch<Branch>(
      showSearchBox: true,
      onChanged: widget.onChanged,
      onFind: (String? filter) => getData(filter),
      itemAsString: (items) {
        return items!.name ?? Field.empty ;
      },
      dropdownSearchDecoration: InputDecoration(
        hintText: Str.selectBranch,
        filled: true,
        fillColor: Colors.black12.withOpacity(0.05),
        contentPadding: const EdgeInsets.fromLTRB(15, 12, 0, 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Future<List<Branch>> getData(filter) async {
    return currencyListNew;
  }
}

// ?? DROPDOWN CURRENCY
class DropDownCurrency extends StatefulWidget {
  const DropDownCurrency(
      {Key? key,
      this.currency,
      this.currencyName,
      this.currencyExchangeRate,
      // required this.currencyList,
      required this.onChanged})
      : super(key: key);

  final String? currency, currencyName, currencyExchangeRate;
  final void Function(Currency?) onChanged;
  // final List<Currency> currencyList;

  @override
  _DropDownCurrencyState createState() => _DropDownCurrencyState();
}

class _DropDownCurrencyState extends State<DropDownCurrency> {
  List<Currency> currencyListNew = [];

  void getCurrency() async {
    final response = await http.get(API.listOfCurrency, headers: headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);

      for (var currency in jsonBody[Field.data]) {
        final currencies = Currency.fromMap(currency);

        setState(() {
          currencyListNew.add(currencies);
        });
      }
    } else {
      print(Status.failed);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrency();
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   padding: const EdgeInsets.only(left: 15, right: 15),
    //   decoration: BoxDecoration(
    //     color: Colors.black12.withOpacity(0.05),
    //     borderRadius: BorderRadius.circular(7.0),
    //   ),
    //   child: DropdownButtonHideUnderline(
    //     child: DropdownButton(
    //       dropdownColor: Styles.greyColor,
    //       icon: const RotatedBox(
    //           quarterTurns: 3,
    //           child: Icon(
    //             Icons.chevron_left,
    //             size: 20,
    //             color: Styles.textColor,
    //           )),
    //       hint: widget.currencyName == null
    //           ? Text(Str.currency, style: Styles.primaryTitle)
    //           : Text(
    //               widget.currencyName!,
    //               style: Styles.primaryTitle,
    //             ),
    //       isExpanded: true,
    //       iconSize: 30.0,
    //       style: Styles.primaryTitle,
    //       items: currencyListNew.map(
    //         (val) {
    //           return DropdownMenuItem<Currency>(
    //             value: val,
    //             child: Text(val.name ?? Field.emptyString),
    //           );
    //         },
    //       ).toList(),
    //       onChanged: widget.onChanged,
    //     ),
    //   ),
    // );
    return _dropDownSearch();
  }

  _dropDownSearch() {
    return DropdownSearch<Currency>(
      showSearchBox: true,
      onChanged: widget.onChanged,
      onFind: (String? filter) => getData(filter),
      itemAsString: (items) {
        return items!.name ?? Field.empty;
      },
      dropdownSearchDecoration: InputDecoration(
        hintText: Str.selectCurrency,
        filled: true,
        fillColor: Colors.black12.withOpacity(0.05),
        contentPadding: const EdgeInsets.fromLTRB(15, 12, 0, 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Future<List<Currency>> getData(filter) async {
    return currencyListNew;
  }
}

// ?? DROPDOWN FDR PLAN

class DropDownPlanFDR extends StatefulWidget {
  const DropDownPlanFDR(
      {Key? key, this.plan, this.planName, required this.onChanged})
      : super(key: key);

  final String? plan, planName;
  final void Function(PlanFDR?) onChanged;

  @override
  _DropDownPlanFDRState createState() => _DropDownPlanFDRState();
}

class _DropDownPlanFDRState extends State<DropDownPlanFDR> {
  List<PlanFDR> planListNew = [];

  void getCurrency() async {
    final response = await http.get(API.listofFdrPlans, headers: headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);

      for (var plan in jsonBody[Field.data]) {
        final plans = PlanFDR.fromMap(plan);
        
        setState(() {
          planListNew.add(plans);
        });
      }
    } else {
      print(Status.failed);
    }
  }

  @override
  void initState() {
    getCurrency();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   padding: const EdgeInsets.only(left: 15, right: 15),
    //   decoration: BoxDecoration(
    //     color: Colors.black12.withOpacity(0.05),
    //     borderRadius: BorderRadius.circular(7.0),
    //   ),
    //   child: DropdownButtonHideUnderline(
    //     child: DropdownButton(
    //       dropdownColor: Styles.greyColor,
    //       icon: const RotatedBox(
    //           quarterTurns: 3,
    //           child: Icon(
    //             Icons.chevron_left,
    //             size: 20,
    //             color: Styles.textColor,
    //           )),
    //       hint: widget.planName == null
    //           ? Text(Str.plan, style: Styles.primaryTitle)
    //           : Text(
    //               widget.planName!,
    //               style: Styles.primaryTitle,
    //             ),
    //       isExpanded: true,
    //       iconSize: 30.0,
    //       style: Styles.primaryTitle,
    //       items: planListNew.map(
    //         (val) {
    //           return DropdownMenuItem<PlanFDR>(
    //             value: val,
    //             child: Text(val.name ?? '-'),
    //           );
    //         },
    //       ).toList(),
    //       onChanged: widget.onChanged,
    //     ),
    //   ),
    // );
    return _dropDownSearch();
  }

  _dropDownSearch() {
    return DropdownSearch<PlanFDR>(
      showSearchBox: true,
      onChanged: widget.onChanged,
      onFind: (String? filter) => getData(filter),
      itemAsString: (items) {
        return items!.name ?? Field.empty ;
      },
      dropdownSearchDecoration: InputDecoration(
        hintText: Str.selectPlanFdr,
        filled: true,
        fillColor: Colors.black12.withOpacity(0.05),
        contentPadding: const EdgeInsets.fromLTRB(15, 12, 0, 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Future<List<PlanFDR>> getData(filter) async {
    return planListNew;
  }
}

// ?? DROPDOWN MEMBERSHIP PLAN

class DropDownMembershipPlan extends StatefulWidget {
  const DropDownMembershipPlan(
      {Key? key, this.membershipPlan, this.membershipName, this.membershipFee, required this.onChanged})
      : super(key: key);

  final String? membershipPlan, membershipName, membershipFee;
  final void Function(Membership?) onChanged;

  @override
  _DropDownMembershipPlanState createState() => _DropDownMembershipPlanState();
}

class _DropDownMembershipPlanState extends State<DropDownMembershipPlan> {
  List<Membership> planListNew = [];

  void getView() async {
    final response = await http.get(API.membershipPlanList, headers: headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);

      for (var plan in jsonBody[Field.data]) {
        final plans = Membership.fromMap(plan);
        
        setState(() {
          planListNew.add(plans);
        });
      }
    } else {
      print(Status.failed);
    }
  }

  @override
  void initState() {
    getView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
    //   decoration: BoxDecoration(
    //     color: Colors.black12.withOpacity(0.05),
    //     borderRadius: BorderRadius.circular(15.0),
    //   ),
    //   child: DropdownButtonHideUnderline(
    //     child: DropdownButton(
    //       dropdownColor: Styles.greyColor,
    //       icon: const RotatedBox(
    //           quarterTurns: 3,
    //           child: Icon(
    //             Icons.chevron_left,
    //             size: 20,
    //             color: Styles.textColor,
    //           )),
    //       hint: widget.membershipName == null
    //           ? Text(Str.membershipPlan, style: Styles.primaryTitle)
    //           : Text(
    //               widget.membershipName!,
    //               style: Styles.primaryTitle,
    //             ),
    //       isExpanded: true,
    //       iconSize: 30.0,
    //       style: Styles.primaryTitle,
    //       items: planListNew.map(
    //         (val) {
    //           return DropdownMenuItem<Membership>(
    //             value: val,
    //             child: Text(val.planName ?? '-'),
    //           );
    //         },
    //       ).toList(),
    //       onChanged: widget.onChanged,
    //     ),
    //   ),
    // );
    return _dropDownSearch();
  }

  _dropDownSearch() {
    return DropdownSearch<Membership>(
      showSearchBox: true,
      onChanged: widget.onChanged,
      onFind: (String? filter) => getData(filter),
      itemAsString: (items) {
        return items!.planName ?? Field.empty ;
      },
      dropdownSearchDecoration: InputDecoration(
        hintText: Str.selectMembership,
        filled: true,
        fillColor: Colors.black12.withOpacity(0.05),
        contentPadding: const EdgeInsets.fromLTRB(15, 12, 0, 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Future<List<Membership>> getData(filter) async {
    return planListNew;
  }
}

// ?? DROPDOWN NAVIGATION MENU

class DropDowNavigation extends StatefulWidget {
  const DropDowNavigation(
      {Key? key, this.navigation, this.navigationName, required this.onChanged})
      : super(key: key);

  final String? navigation, navigationName;
  final void Function(Navigation?) onChanged;

  @override
  _DropDowNavigationState createState() => _DropDowNavigationState();
}

class _DropDowNavigationState extends State<DropDowNavigation> {
  List<Navigation> navigationListNew = [];

  void read() async {
    final response = await http.get(AdminAPI.listOfNavigation, headers: headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);

      for (var data in jsonBody[Field.data]) {
        final navigations = Navigation.fromMap(data);
        
        setState(() {
          navigationListNew.add(navigations);
        });
      }
    } else {
      print(Status.failed);
    }
  }

  @override
  void initState() {
    read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
    //   decoration: BoxDecoration(
    //     color: Colors.black12.withOpacity(0.05),
    //     borderRadius: BorderRadius.circular(15.0),
    //   ),
    //   child: DropdownButtonHideUnderline(
    //     child: DropdownButton(
    //       dropdownColor: Styles.greyColor,
    //       icon: const RotatedBox(
    //           quarterTurns: 3,
    //           child: Icon(
    //             Icons.chevron_left,
    //             size: 20,
    //             color: Styles.textColor,
    //           )),
    //       hint: widget.navigationName == null
    //           ? Text(Str.navigation, style: Styles.primaryTitle)
    //           : Text(
    //               widget.navigationName!,
    //               style: Styles.primaryTitle,
    //             ),
    //       isExpanded: true,
    //       iconSize: 30.0,
    //       style: Styles.primaryTitle,
    //       items: navigationListNew.map(
    //         (val) {
    //           return DropdownMenuItem<Navigation>(
    //             value: val,
    //             child: Text(val.name ?? '-'),
    //           );
    //         },
    //       ).toList(),
    //       onChanged: widget.onChanged,
    //     ),
    //   ),
    // );
    return _dropDownSearch();
  }


  _dropDownSearch() {
    return DropdownSearch<Navigation>(
      showSearchBox: true,
      onChanged: widget.onChanged,
      onFind: (String? filter) => getData(filter),
      itemAsString: (items) {
        return items!.name ?? Field.empty ;
      },
      dropdownSearchDecoration: InputDecoration(
        hintText: Str.selectNavigation,
        filled: true,
        fillColor: Colors.black12.withOpacity(0.05),
        contentPadding: const EdgeInsets.fromLTRB(15, 12, 0, 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Future<List<Navigation>> getData(filter) async {
    return navigationListNew;
  }
}

// ?? DROPDOWN USER ROLES

class DropDownUserRoles extends StatefulWidget {
   const DropDownUserRoles(
      {Key? key,
      this.role,
      this.roleName,
      // required this.roleList,
      required this.onChanged
      })
      : super(key: key);

  final String? role, roleName;
  final void Function(UserRole?) onChanged;
  // final List<UserRole> roleList;

  @override
  _DropDownUserRolesState createState() => _DropDownUserRolesState();
}

class _DropDownUserRolesState extends State<DropDownUserRoles> {
  List<UserRole> roleListNew = [];

  void getUserRole() async {
    final response = await http.get(AdminAPI.listOfUserRole, headers: headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);

      for (var role in jsonBody[Field.data]) {
        final data = UserRole.fromMap(role);

        setState(() {
          roleListNew.add(data);
        });
      }
    } else {
      print(Status.failed);
    }
  }

  @override
  void initState() {
    super.initState();
    getUserRole();
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
    //   decoration: BoxDecoration(
    //     color: Colors.black12.withOpacity(0.05),
    //     borderRadius: BorderRadius.circular(15.0),
    //   ),
    //   child: DropdownButtonHideUnderline(
    //     child: DropdownButton(
          
    //       dropdownColor: Styles.greyColor,
    //       icon: const RotatedBox(
    //           quarterTurns: 3,
    //           child: Icon(
    //             Icons.chevron_left,
    //             size: 20,
    //             color: Styles.textColor,
    //           )),
    //       hint: widget.roleName == null
    //           ? Text(Str.role, style: Styles.primaryTitle)
    //           : Text(
    //               widget.roleName!,
    //               style: Styles.primaryTitle,
    //             ),
    //       isExpanded: true,
    //       iconSize: 30.0,
    //       style: Styles.primaryTitle,
    //       items: roleListNew.map(
    //         (val) {
    //           return DropdownMenuItem<UserRole>(
    //             value: val,
    //             child: Text(val.description ?? Field.emptyString),
    //           );
    //         },
    //       ).toList(),
    //       onChanged: widget.onChanged,
    //     ),
    //   ),
    // );
    return _dropDownSearch();
  }

  _dropDownSearch() {
    return DropdownSearch<UserRole>(
      showSearchBox: true,
      onChanged: widget.onChanged,
      onFind: (String? filter) => getData(filter),
      itemAsString: (planListNew) {
        return planListNew!.description ?? Field.empty ;
      },
      dropdownSearchDecoration: InputDecoration(
        hintText: Str.selectRole,
        filled: true,
        fillColor: Colors.black12.withOpacity(0.05),
        contentPadding: const EdgeInsets.fromLTRB(15, 12, 0, 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Future<List<UserRole>> getData(filter) async {
    return roleListNew;
  }
}

// ?? DROPDOWN STAFF

class DropDownStaff extends StatefulWidget {
  const DropDownStaff(
      {Key? key,
      this.users,
      this.usersName,
      // required this.usersList,
      required this.onChanged})
      : super(key: key);

  final String? users, usersName;
  final void Function(Users?) onChanged;
  // final List<Users> usersList;

  @override
  _DropDownStaffState createState() => _DropDownStaffState();
}

class _DropDownStaffState extends State<DropDownStaff> {
  List<Users> userListNew = [];
  SharedPref sharedPref = SharedPref();

  void getCurrency() async {
    User user = User.fromJSON(await sharedPref.read(Pref.userData));
    String userId = user.id.toString();

    Uri viewSingleUser = Uri.parse(API.listofStaff.toString() + userId);
    final response = await http.get(viewSingleUser, headers: headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);

      for (var data in jsonBody[Field.data]) {
        final user = Users.fromMap(data);

        setState(() {
          userListNew.add(user);
        });
      }
    } else {
      print(Status.failed);
    }
  }

  @override
  void initState() {
    getCurrency();
    super.initState();
    print(userListNew);
  }

  @override
  Widget build(BuildContext context) {
    return _dropDownSearch();
  }

  _dropDownSearch() {
    return DropdownSearch<Users>(
      showSearchBox: true,
      onChanged: widget.onChanged,
      itemAsString: (planListNew) {
        return planListNew!.name ?? Field.empty ;
      },
      onFind: (String? filter) => getData(filter),
      dropdownSearchDecoration: InputDecoration(
        labelText: Str.selectUser,
        contentPadding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.black12.withOpacity(0.05),
      ),
    );
  }

  Future<List<Users>> getData(filter) async {
    return userListNew;
  }
}

// ?? DROPDOWN USER WITH WALLET DETAILS
class DropDownUserWallet extends StatefulWidget {
  const DropDownUserWallet(
      {Key? key,
      this.users,
      this.usersName,
      this.walletBalance,
      this.walletId,
      required this.onChanged})
      : super(key: key);

  final String? users, usersName, walletBalance, walletId;
  final void Function(UserWallet?) onChanged;
  // final List<Users> usersList;

  @override
  _DropDownUserWalletState createState() => _DropDownUserWalletState();
}

class _DropDownUserWalletState extends State<DropDownUserWallet> {
  List<UserWallet> userListNew = [];
  SharedPref sharedPref = SharedPref();

  void getCurrency() async {
    Uri viewSingleUser = Uri.parse(AdminAPI.showSavings.toString());
    final response = await http.get(viewSingleUser, headers: headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);

      for (var data in jsonBody[Field.data]) {
        final user = UserWallet.fromMap(data);

        setState(() {
          userListNew.add(user);
        });
      }
    } else {
      print(Status.failed);
    }
  }

  @override
  void initState() {
    getCurrency();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _dropDownSearch();
  }

  _dropDownSearch() {
    return DropdownSearch<UserWallet>(
      showSearchBox: true,
      onChanged: widget.onChanged,
      onFind: (String? filter) => getData(filter),
      itemAsString: (planListNew) {
        return planListNew!.userName ?? Field.empty ;
      },
      dropdownSearchDecoration: InputDecoration(
        hintText: Str.selectWallet,
        filled: true,
        fillColor: Colors.black12.withOpacity(0.05),
        contentPadding: const EdgeInsets.fromLTRB(15, 12, 0, 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Future<List<UserWallet>> getData(filter) async {
    return userListNew;
  }
}

// ?? DROPDOWN USERS
class DropDownUser extends StatefulWidget {
  const DropDownUser(
      {Key? key,
      this.users,
      this.usersName,
      // required this.usersList,
      required this.onChanged})
      : super(key: key);

  final String? users, usersName;
  final void Function(Users?) onChanged;
  // final List<Users> usersList;

  @override
  _DropDownUserState createState() => _DropDownUserState();
}

class _DropDownUserState extends State<DropDownUser> {
  List<Users> userListNew = [];
  SharedPref sharedPref = SharedPref();

  void getCurrency() async {
    User user = User.fromJSON(await sharedPref.read(Pref.userData));
    String userId = user.id.toString();

    Uri viewSingleUser = Uri.parse(API.listofCustomer.toString() + userId);
    final response = await http.get(viewSingleUser, headers: headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);

      for (var data in jsonBody[Field.data]) {
        final user = Users.fromMap(data);

        setState(() {
          userListNew.add(user);
        });
      }
    } else {
      print(Status.failed);
    }
  }

  @override
  void initState() {
    getCurrency();
    super.initState();
    print(userListNew);
  }

  @override
  Widget build(BuildContext context) {
    return _dropDownSearch();
  }

  _dropDownSearch() {
    return DropdownSearch<Users>(
      showSearchBox: true,
      onChanged: widget.onChanged,
      itemAsString: (planListNew) {
        return planListNew!.name ?? Field.empty ;
      },
      onFind: (String? filter) => getData(filter),
      dropdownSearchDecoration: InputDecoration(
        labelText: Str.selectUser,
        contentPadding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.black12.withOpacity(0.05),
      ),
    );
  }

  Future<List<Users>> getData(filter) async {
    return userListNew;
  }
}
