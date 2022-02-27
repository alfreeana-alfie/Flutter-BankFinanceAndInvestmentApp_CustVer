import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/models/user_wallet.dart';
import 'package:flutter_banking_app/models/users.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:http/http.dart' as http;

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
