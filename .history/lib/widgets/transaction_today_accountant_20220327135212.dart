import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/models/wallet_transaction.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

// ?? 
class TransactionTodayListAccountant extends StatefulWidget {
  const TransactionTodayListAccountant({Key? key, required this.userLoad})
      : super(key: key);

  final User userLoad;

  @override
  _TransactionTodayListAccountantState createState() =>
      _TransactionTodayListAccountantState();
}

class _TransactionTodayListAccountantState
    extends State<TransactionTodayListAccountant> {
  SharedPref sharedPref = SharedPref();
  List<WalletTransaction> transactionListNew = [];

  Future getCurrency() async {
    print(widget.userLoad.id.toString());
    final response = await http.get(
        Uri.parse(AdminAPI.listOfWalletTransactionsAccountant.toString() +
            widget.userLoad.id.toString()),
        headers: headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);

      for (var data in jsonBody[Field.data]) {
        final transaction = WalletTransaction.fromMap(data);
        if (mounted) {
          transactionListNew.add(transaction);
        }
      }
    } else {
      print(Status.failed);
    }
  }

  // @override
  // void initState() {
  //   getCurrency();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCurrency(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Styles.accentColor,
            ),
          );
        } else {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: transactionListNew.length,
              itemBuilder: (BuildContext context, int i) {
                // final trs = transactions[i];

                DateTime tempDate =
                    DateTime.parse(transactionListNew[i].createdAt ?? '-');
                String createdAt =
                    DateFormat('dd-MM-yyyy hh:mm aa').format(tempDate);

                return ListTile(
                  isThreeLine: true,
                  minLeadingWidth: 10,
                  contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  title: Text('${transactionListNew[i].userName!.toUpperCase()} - ${transactionListNew[i].paymentMethod}',
                      style: const TextStyle(color: Styles.textColor)),
                  subtitle: Text(createdAt,
                      style:
                          TextStyle(color: Styles.textColor.withOpacity(0.5))),
                  trailing: Text(
                      'NGN ${double.parse(transactionListNew[i].amount ?? '0').toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 17, color: Styles.textColor)),
                );
              },
            );
          }
        }
      },
    );
  }

  // ListView.builder(
  //     shrinkWrap: true,
  //     physics: const BouncingScrollPhysics(),
  //     itemCount: transactionListNew.length,
  //     itemBuilder: (BuildContext context, int  i) {
  //       // final trs = transactions[i];

  //       DateTime tempDate = DateTime.parse(transactionListNew[i].createdAt ?? '-');
  //       String createdAt = DateFormat('dd-MM-yyyy hh:mm aa').format(tempDate);

  //       return ListTile(
  //         isThreeLine: true,
  //         minLeadingWidth: 10,
  //         contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
  //         title: Text(transactionListNew[i].userId ?? 'User',
  //             style: const TextStyle(color: Styles.textColor)),
  //         subtitle: Text(createdAt,
  //             style: TextStyle(color: Styles.textColor.withOpacity(0.5))),
  //         trailing: Text('NGN ${double.parse(transactionListNew[i].amount ?? '0').toStringAsFixed(2)}',
  //             style: const TextStyle(fontSize: 17, color: Styles.textColor)),
  //       );
  //     },
  //   );
}
