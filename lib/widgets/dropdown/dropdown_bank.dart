import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_banking_app/models/bank.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/iconly/iconly_bold.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:http/http.dart' as http;

class DropDownBank extends StatefulWidget {
  const DropDownBank(
      {Key? key, this.bank, this.bankName, required this.onChanged})
      : super(key: key);

  final String? bank, bankName;
  final void Function(Bank?) onChanged;

  @override
  _DropDownBankState createState() => _DropDownBankState();
}

class _DropDownBankState extends State<DropDownBank> {
  List<Bank> planListNew = [];

  void getCurrency() async {
    final response = await http.get(API.listofFdrPlans, headers: headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);

      for (var plan in jsonBody[Field.data]) {
        final plans = Bank.fromMap(plan);
        
        setState(() {
          planListNew.add(plans);
        });
      }
    } else {
      print(Status.failedTxt);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrency();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
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
            hint: widget.bankName == null
                ? Text(Str.planTxt, style: Styles.primaryTitle)
                : Text(
                    widget.bankName!,
                    style: Styles.primaryTitle,
                  ),
            isExpanded: true,
            iconSize: 30.0,
            style: Styles.primaryTitle,
            items: planListNew.map(
              (val) {
                return DropdownMenuItem<Bank>(
                  value: val,
                  child: Text(val.name ?? '-'),
                );
              },
            ).toList(),
            onChanged: widget.onChanged,
          ),
        ),
      ),
    );
  }
}
