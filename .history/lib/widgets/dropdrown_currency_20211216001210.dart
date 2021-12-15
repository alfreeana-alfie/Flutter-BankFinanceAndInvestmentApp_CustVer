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
      required this.currencyList,
      required this.onChanged
      })
      : super(key: key);

  final String? currency;
  final void Function(String?) onChanged;
  final List<Currency> currencyList;

  @override
  _DropDownCurrencyState createState() => _DropDownCurrencyState();
}

class _DropDownCurrencyState extends State<DropDownCurrency> {
  List<Currency> currencyListNew = [];

  void getCurrency() async {
    final response = await http.get(API.listOfCurrency, headers: API.headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);
      // var jsonData = Currency.fromMap(jsonBody);

      for (var currency in jsonBody['data']) {
        final currencies = Currency.fromMap(currency);

        setState(() {
          currencyListNew.add(currencies);
        });
      }

      // print(jsonData.name);
    } else {
      print(Status.failedTxt);
    }
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
            hint: currency == null
                ? Text(Str.currencyTxt, style: Styles.subtitleStyle02)
                : Text(
                    currency!,
                    style: Styles.subtitleStyle,
                  ),
            isExpanded: true,
            iconSize: 30.0,
            style: Styles.subtitleStyle02,
            items: currencyList.map(
              (val) {
                return DropdownMenuItem<String>(
                  value: val.name,
                  child: Text(val.name),
                );
              },
            ).toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}

// class DropDownCurrency extends StatelessWidget {
//   const DropDownCurrency(
//       {Key? key,
//       this.currency,
//       required this.currencyList,
//       required this.onChanged
//       })
//       : super(key: key);

//   final String? currency;
//   final void Function(String?) onChanged;
//   final List<Currency> currencyList;

//   List<Currency> currencyListNew = [];

//   void getCurrency() async {
//     final response = await http.get(API.listOfCurrency, headers: API.headers);

//     if (response.statusCode == Status.ok) {
//       var jsonBody = jsonDecode(response.body);
//       // var jsonData = Currency.fromMap(jsonBody);

//       for (var currency in jsonBody['data']) {
//         final currencies = Currency.fromMap(currency);

//         setState(() {
//           currencyListNew.add(currencies);
//         });
//       }

//       // print(jsonData.name);
//     } else {
//       print(Status.failedTxt);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
//         decoration: BoxDecoration(
//           color: Styles.primaryColor,
//           borderRadius: BorderRadius.circular(15.0),
//         ),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton(
//             dropdownColor: Styles.primaryColor,
//             hint: currency == null
//                 ? Text(Str.currencyTxt, style: Styles.subtitleStyle02)
//                 : Text(
//                     currency!,
//                     style: Styles.subtitleStyle,
//                   ),
//             isExpanded: true,
//             iconSize: 30.0,
//             style: Styles.subtitleStyle02,
//             items: currencyList.map(
//               (val) {
//                 return DropdownMenuItem<String>(
//                   value: val.name,
//                   child: Text(val.name),
//                 );
//               },
//             ).toList(),
//             onChanged: onChanged,
//           ),
//         ),
//       ),
//     );
//   }
// }
