import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/models/wallet.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:http/http.dart' as http;

class DropDownAccount extends StatefulWidget {
  const DropDownAccount(
      {Key? key,
      this.account,
      this.accountName,
      this.userId,
      this.accountBalance,
      this.walletId,
      required this.onChanged})
      : super(key: key);

  final String? userId, account, accountName, accountBalance, walletId;
  final void Function(Wallet?) onChanged;

  @override
  _DropDownAccountState createState() => _DropDownAccountState();
}

class _DropDownAccountState extends State<DropDownAccount> {
  List<Wallet> planListNew = [];

  void getList() async {
    Uri viewSingleUser = Uri.parse(API.listOfWallet.toString() + '3');
    final response = await http.get(viewSingleUser, headers: headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);

      for (var plan in jsonBody[Field.data]) {
        final plans = Wallet.fromMap(plan);

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
    getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
  }

  

  _dropDownSearch() {
    return DropdownSearch<String>(
      //mode of dropdown
      mode: Mode.DIALOG,
      //to show search box
      showSearchBox: true,
      showSelectedItems: true,
      //list of dropdown items
      items: ["India", "USA", "Brazil", "Canada", "Australia", "Singapore"],
      onChanged: print,
      label: "Country",
      //show selected item
      selectedItem: "India",
    );
  }
}
