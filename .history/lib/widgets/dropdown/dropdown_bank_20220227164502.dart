import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/models/bank.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:http/http.dart' as http;

class DropDownBank extends StatefulWidget {
  const DropDownBank(
      {Key? key, this.bank, this.bankName, this.swiftCode, required this.onChanged})
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
    return _dropDownSearch();
  }

  _dropDownSearch() {
    return DropdownSearch<Bank>(
      showSearchBox: true,
      onChanged: widget.onChanged,
      onFind: (String? filter) => getData(filter),
      itemAsString: (items) {
        return items!.name ?? Field.empty ;
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
