import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_banking_app/models/currency.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:http/http.dart' as http;

class DropDownCurrency extends StatefulWidget {
   const DropDownCurrency(
      {Key? key,
      this.currency,
      // required this.currencyList,
      required this.onChanged
      })
      : super(key: key);

  final String? currency;
  final void Function(Currency?) onChanged;
  // final List<Currency> currencyList;

  @override
  _DropDownCurrencyState createState() => _DropDownCurrencyState();
}

class _DropDownCurrencyState extends State<DropDownCurrency> {
  List<Currency> currencyListNew = [];

  void getCurrency() async {
    final response = await http.get(API.listOfCurrency, headers: API.headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);

      for (var currency in jsonBody[Field.data]) {
        final currencies = Currency.fromMap(currency);

        setState(() {
          currencyListNew.add(currencies);
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
          color: Styles.primaryColor,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            dropdownColor: Styles.primaryColor,
            hint: widget.currency == null
                ? Text(Str.currencyTxt, style: Styles.subtitleStyle02)
                : Text(
                    widget.currency!,
                    style: Styles.subtitleStyle,
                  ),
            isExpanded: true,
            iconSize: 30.0,
            style: Styles.subtitleStyle02,
            items: currencyListNew.map(
              (val) {
                return DropdownMenuItem<Currency>(
                  value: val,
                  child: Text(val.name),
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