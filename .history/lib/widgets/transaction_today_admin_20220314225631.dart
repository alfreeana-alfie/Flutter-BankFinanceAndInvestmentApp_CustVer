import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/wallet_transaction.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class TransactionTodayListAdmin extends StatefulWidget {
  const TransactionTodayListAdmin({Key? key}) : super(key: key);

  @override
  _TransactionTodayListAdminState createState() =>
      _TransactionTodayListAdminState();
}

class _TransactionTodayListAdminState extends State<TransactionTodayListAdmin> {
  SharedPref sharedPref = SharedPref();
  List<WalletTransaction> transactionListNew = [];

  void getCurrency() async {
    final response =
        await http.get(AdminAPI.listOfWalletTransactions, headers: headers);

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
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: transactionListNew.length,
      itemBuilder: (BuildContext context, int i) {
        // final trs = transactions[i];

        String? method;

        switch (transactionListNew[i].method) {
          case 'send_money':
            method = 'Send Money';
            break;

          case 'exchange_money':
            method = 'Exchange Money';
            break;

          case 'wire_transfer':
            method = 'Wire Transfer';
            break;

          case 'top_up_account':
            method = 'Top Up by Accountant';
            break;

          case 'top_up':
            method = 'Top Up';
            break;

          case 'sms_subcribed':
            method = 'SMS Subcription';
            break;
          case 'withdraw':
            method = 'Withdraw';
            break;

          default:
        }

        DateTime tempDate =
            DateTime.parse(transactionListNew[i].createdAt ?? '-');
        String createdAt = DateFormat('dd-MM-yyyy hh:mm aa').format(tempDate);

        return ListTile(
          isThreeLine: true,
          minLeadingWidth: 10,
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          title: Text(
              '${transactionListNew[i].userName!.toUpperCase()} - $method',
              style: const TextStyle(color: Styles.textColor)),
          subtitle: Text(createdAt,
              style: TextStyle(color: Styles.textColor.withOpacity(0.5))),
          trailing: Text(
              'NGN ${double.parse(transactionListNew[i].amount ?? '0').toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 17, color: Styles.textColor)),
        );
      },
    );
  }
}
