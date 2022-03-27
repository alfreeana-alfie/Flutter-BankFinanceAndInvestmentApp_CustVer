import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/bank.dart';
import 'package:flutter_banking_app/models/branch.dart';
import 'package:flutter_banking_app/models/user.dart';
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
    // return Container(
    //   padding: const EdgeInsets.only(left: 15, right: 15),
    //   decoration: BoxDecoration(
    //     color: Colors.black12.withOpacity(0.05),
    //     borderRadius: BorderRadius.circular(7.0),
    //   ),
    //   child: DropdownButtonHideUnderline(
    //     child: DropdownButton<Wallet>(
    //       dropdownColor: Styles.greyColor,
    //       icon: const RotatedBox(
    //           quarterTurns: 3,
    //           child: Icon(
    //             Icons.chevron_left,
    //             size: 20,
    //             color: Styles.textColor,
    //           )),
    //       hint: widget.accountName == null
    //           ? Text(Str.selectAccount, style: Styles.primaryTitle)
    //           : Text(
    //               widget.accountName!,
    //               style: Styles.primaryTitle,
    //             ),
    //       isExpanded: true,
    //       iconSize: 30.0,
    //       style: Styles.primaryTitle,
    //       items: planListNew.map(
    //         (val) {
    //           return DropdownMenuItem<Wallet>(
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
    //       hint: widget.branchName == null
    //           ? Text(Str.currency, style: Styles.primaryTitle)
    //           : Text(
    //               widget.branchName!,
    //               style: Styles.primaryTitle,
    //             ),
    //       isExpanded: true,
    //       iconSize: 30.0,
    //       style: Styles.primaryTitle,
    //       items: currencyListNew.map(
    //         (val) {
    //           return DropdownMenuItem<Branch>(
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


