import 'package:flutter/material.dart';
import 'package:flutter_banking_app/models/currency.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';

class DropDownCurrency extends StatelessWidget {
  const DropDownCurrency({Key? key}) : super(key: key);

  final String currency;
  final VoidCallback onChanged;
  final 
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
            items: widget.currencyList.map(
              (val) {
                return DropdownMenuItem<String>(
                  value: val.id.toString(),
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
