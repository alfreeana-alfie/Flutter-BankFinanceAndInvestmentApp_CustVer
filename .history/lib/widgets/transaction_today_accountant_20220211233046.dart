import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/wallet_transaction.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class TransactionTodayListAccountant extends StatefulWidget {
  const TransactionTodayListAccountant({Key? key}) : super(key: key);

  @override
  _TransactionTodayListAccountantState createState() => _TransactionTodayListAccountantState();
}

class _TransactionTodayListAccountantState extends State<TransactionTodayListAccountant> {
  SharedPref sharedPref = SharedPref();
  List<WalletTransaction> transactionListNew = [];

  void getCurrency() async {
    final response = await http.get(AdminAPI.listOfWalletTransactionsAccountant, headers: headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);

      for (var data in jsonBody[Field.data]) {
        final transaction = WalletTransaction.fromMap(data);

        // print(transaction.amount);

        setState(() {
          transactionListNew.add(transaction);
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
    return FutureBuilder(builder: builder)
  }
}
