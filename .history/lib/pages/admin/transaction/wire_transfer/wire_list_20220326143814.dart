import 'dart:convert';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/deposit.dart';
import 'package:flutter_banking_app/models/transaction.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/card/card_deposit.dart';
import 'package:flutter_banking_app/widgets/card/card_transaction.dart';
import 'package:flutter_banking_app/widgets/card/card_admin_wire_transfer.dart';
import 'package:flutter_banking_app/widgets/left_menu.dart';
import 'package:flutter_banking_app/widgets/left_menu_member.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:oktoast/oktoast.dart';

class WireTransferList extends StatefulWidget {
  const WireTransferList({Key? key}) : super(key: key);

  @override
  _WireTransferListState createState() => _WireTransferListState();
}

class _WireTransferListState extends State<WireTransferList> {
  SharedPref sharedPref = SharedPref();
  User userLoad = User();
  late Map<String, dynamic> requestMap;
  List<Deposit> transactionList = [];

  Future view() async {
    final response =
        await http.get(AdminAPI.listOfWireTransfer, headers: headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);
      for (var req in jsonBody[Field.data]) {
        final data = Deposit.fromMap(req);
        if (mounted) {
          transactionList.add(data);
        }
      }
    } else {
      print(Status.failed);
      CustomToast.showMsg(Status.failed, Styles.dangerColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: addAppBar(
      //   title: Str.fdrHistory,
      //   implyLeading: true,
      //   context: context,
      //   hasAction: true,
      //   path: RouteSTR.addFdrM,
      // ),
      drawer: const SideDrawer(),
      backgroundColor: Styles.primaryColor,
      body: _innerContainer(),
    );
  }

  _innerContainer() {
    return FutureBuilder(
      future: view(),
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
            return Column(
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () => Scaffold.of(context).openDrawer(),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Styles.transparentColor,
                            ),
                            child: const Icon(
                              Icons.menu,
                              color: Styles.accentColor,
                            ),
                          ),
                        ),
                        const Gap(10),
                        Center(
                          child: Text(
                            Str.wireTransferList,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Styles.textColor,
                                fontSize: 19),
                          ),
                        ),
                        const Gap(10),
                        InkWell(
                          // onTap: () => Navigator.pushNamed(context, RouteSTR.addLoanM),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Styles.transparentColor,
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Styles.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return CardWireTransfer(
                        deposit: transactionList[index],
                        depositList: transactionList,
                        index: index,
                      );
                    },
                    itemCount: transactionList.length,
                  ),
                ),
                // for (Transaction transaction in transactionList)
                //   CardTransaction(transaction: transaction),
              ],
            );
          }
        }
      },
    );
  }
}
