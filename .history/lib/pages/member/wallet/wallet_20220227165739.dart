import 'dart:convert';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/models/wallet.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/card/card_wallet.dart';
import 'package:flutter_banking_app/widgets/left_menu_member.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  SharedPref sharedPref = SharedPref();
  User userLoad = User();
  late Map<String, dynamic> requestMap;
  List<Wallet> transactionList = [];

  Future view() async {
    User user = User.fromJSON(await sharedPref.read(Pref.userData));
    String userId = user.id.toString();
    Uri viewSingleUser = Uri.parse(API.listOfWallet.toString() + userId);
    final response = await http.get(viewSingleUser, headers: headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);
      for (var req in jsonBody[Field.data]) {
        final data = Wallet.fromMap(req);
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
      drawer: const SideDrawerMember(),
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
            return ExpandableTheme(
              data: const ExpandableThemeData(
                iconColor: Colors.blue,
                useInkWell: true,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
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
                                Str.myWallet,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Styles.textColor,
                                    fontSize: 19),
                              ),
                            ),
                            const Gap(10),
                            InkWell(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Styles.transparentColor,
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Styles.whiteColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    for (Wallet transaction in transactionList)
                      CardWallet(userWallet: transaction),
                  ],
                ),
              ),
            );
          }
        }
      },
    );
  }
}
