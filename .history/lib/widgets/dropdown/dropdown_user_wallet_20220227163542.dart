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
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        color: Colors.black12.withOpacity(0.05),
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          dropdownColor: Styles.greyColor,
          icon: const RotatedBox(
              quarterTurns: 3,
              child: Icon(
                Icons.chevron_left,
                size: 20,
                color: Styles.textColor,
              )),
          hint: widget.usersName == null
              ? Text(Str.users, style: Styles.primaryTitle)
              : Text(
                  widget.usersName!,
                  style: Styles.primaryTitle,
                ),
          isExpanded: true,
          iconSize: 30.0,
          style: Styles.primaryTitle,
          items: userListNew.map(
            (val) {
              return DropdownMenuItem<UserWallet>(
                value: val,
                child: Text(val.userName ?? Field.emptyString),
              );
            },
          ).toList(),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }

  _dropDownSearch() {
    return DropdownSearch<UserWallet>(
      showSearchBox: true,
      onChanged: widget.onChanged,
      onFind: (String? filter) => getData(filter),
      itemAsString: (planListNew) {
        return planListNew!.name ?? Field.empty ;
      },
      dropdownSearchDecoration: InputDecoration(
        hintText: Str.selectUser,
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
