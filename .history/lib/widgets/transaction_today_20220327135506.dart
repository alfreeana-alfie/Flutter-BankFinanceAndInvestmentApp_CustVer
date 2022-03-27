import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/transaction_overview.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/models/wallet_transaction.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

// ?? TRANSACTION TODAY LIST FOR CUSTOMER
class TransactionTodayList extends StatefulWidget {
  const TransactionTodayList({Key? key}) : super(key: key);

  @override
  _TransactionTodayListState createState() => _TransactionTodayListState();
}

class _TransactionTodayListState extends State<TransactionTodayList> {
  SharedPref sharedPref = SharedPref();
  List<TransactionOverview> transactionListNew = [];

  void getCurrency() async {
    User user = User.fromJSON(await sharedPref.read(Pref.userData));
    String userId = user.id.toString();

    Uri viewSingleUser =
        Uri.parse(API.userTransactionHistoryList.toString() + userId);

    final response = await http.get(viewSingleUser, headers: headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);

      for (var data in jsonBody[Field.data]) {
        final transaction = TransactionOverview.fromMap(data);

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
    super.initState();
    getCurrency();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: transactionListNew.length,
      itemBuilder: (BuildContext context, int  i) {
        // final trs = transactions[i];

        DateTime tempDate = DateTime.parse(transactionListNew[i].createdAt ?? '-');
        String createdAt = DateFormat('dd-MM-yyyy hh:mm aa').format(tempDate);

        // Priority
        String? type;
        switch (transactionListNew[i].type) {
          case 'send_money':
            type = 'Send Money';
            break;
          case 'exchange_money':
            type = 'Exchange Money';
            break;
          case 'wire_transfer':
            type = 'Wire Transfer';
            break;
          case 'deposit':
            type = 'Deposit';
            break;
          case 'withdraw':
            type  = 'Withdrawal';
            break;
          default:
            type = 'Default';
        }

        return ListTile(
          isThreeLine: true,
          minLeadingWidth: 10,
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          // leading:
          // Container(
          //     width: 35,
          //     height: 35,
          //     padding: const EdgeInsets.all(8),
          //     decoration: BoxDecoration(
          //       color: Styles.primaryWithOpacityColor,
          //       boxShadow: [
          //         BoxShadow(
          //           offset: const Offset(0, 1),
          //           color: Styles.textColor.withOpacity(0.1),
          //           blurRadius: 2,
          //           spreadRadius: 1,
          //         )
          //       ],
          //       image: i == 0
          //           ? null
          //           : DecorationImage(
          //               image: AssetImage(trs['avatar']),
          //               fit: BoxFit.cover,
          //             ),
          //       shape: BoxShape.circle,
          //     ),
          //     child: i == 0
          //         ? Icon(trs['icon'], color: const Color(0xFFFF736C), size: 20)
          //         : const SizedBox()),
          title: Text(type,
              style: const TextStyle(color: Styles.textColor)),
          subtitle: Text(createdAt,
              style: TextStyle(color: Styles.textColor.withOpacity(0.5))),
          trailing: Text('${transactionListNew[i].name} ${transactionListNew[i].amount}',
              style: const TextStyle(fontSize: 17, color: Styles.textColor)),
        );
      },
    );
  }
}

// ?? START --TRANSACTION TODAY LIST FOR ACCOUNTANT/ACCOUNT MANAGER
  
// ?? END --TRANSACTION TODAY LIST FOR ACCOUNTANT/ ACCOUNT MANAGER

// ?? TRANSACTION TODAY LIST FOR ADMIN
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
              method = 'SMS Subscription';
              break;
            case 'withdraw':
              method = 'Withdrawal';
              break;
            case 'deposit':
              method = 'Deposit';
              break;
            default:
              method = 'Transaction Record';
              break;
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