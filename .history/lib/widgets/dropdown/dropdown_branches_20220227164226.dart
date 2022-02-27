import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
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

  Future<List<Branch>> getData(filter) async {
    return currencyListNew;
  }
}
