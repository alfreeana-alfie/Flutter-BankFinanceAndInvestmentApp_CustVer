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
      {Key? key, this.account, this.accountName, this.userId, this.accountBalance, this.walletId, required this.onChanged})
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
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
      decoration: BoxDecoration(
        color: Colors.black12.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15.0),
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
          hint: widget.accountName == null
              ? Text(Str.accountType, style: Styles.primaryTitle)
              : Text(
                  '${widget.accountName} - ${widget.accountBalance}',
                  style: Styles.primaryTitle,
                ),
          isExpanded: true,
          iconSize: 30.0,
          style: Styles.primaryTitle,
          items: planListNew.map(
            (val) {
              return DropdownMenuItem<Wallet>(
                value: val,
                child: Text('${val.description} - \$${val.amount}'),
              );
            },
          ).toList(),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }

  _dropDownSearch() {
    return DropdownSearch<Wallet>(
      showSearchBox: true,
      onChanged: widget.onChanged,
      onFind: (String? filter) => getData(filter),
      itemAsString: (items) {
        return '${items!.description} - NGN ${items.amount}';
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
