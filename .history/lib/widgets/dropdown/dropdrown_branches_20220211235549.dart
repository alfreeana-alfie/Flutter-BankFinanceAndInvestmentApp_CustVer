import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_banking_app/models/branch.dart';
import 'package:flutter_banking_app/models/currency.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/iconly/iconly_bold.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:http/http.dart' as http;

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
          hint: widget.currencyName == null
              ? Text(Str.currency, style: Styles.primaryTitle)
              : Text(
                  widget.currencyName!,
                  style: Styles.primaryTitle,
                ),
          isExpanded: true,
          iconSize: 30.0,
          style: Styles.primaryTitle,
          items: currencyListNew.map(
            (val) {
              return DropdownMenuItem<Branch>(
                value: val,
                child: Text(val.name ?? Field.emptyString),
              );
            },
          ).toList(),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
