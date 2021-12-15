import 'package:flutter/material.dart';
import 'package:flutter_banking_app/models/currency.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';

class DropDownCurrency extends StatefulWidget {
  const DropDownCurrency(
      {Key? key,
      this.currency,
      required this.currencyList,
      required this.onChanged})
      : super(key: key);

  final String? currency;
  final VoidCallback onChanged;
  final List<Currency> currencyList;

  @override
  _DropDownCurrencyState createState() => _DropDownCurrencyState();
}

class _DropDownCurrencyState extends State<DropDownCurrency> {
  
}
