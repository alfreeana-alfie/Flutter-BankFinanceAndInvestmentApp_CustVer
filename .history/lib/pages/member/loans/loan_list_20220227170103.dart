import 'dart:convert';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/loans.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/iconly/iconly_bold.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/appbar/app_bar_add.dart';
import 'package:flutter_banking_app/widgets/appbar/menu_add_app_bar.dart';
import 'package:flutter_banking_app/widgets/card/card_loan.dart';
import 'package:flutter_banking_app/widgets/left_menu_member.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:oktoast/oktoast.dart';

class MLoanList extends StatefulWidget {
  const MLoanList({Key? key}) : super(key: key);

  @override
  _MLoanListState createState() => _MLoanListState();
}

class _MLoanListState extends State<MLoanList> {
  SharedPref sharedPref = SharedPref();
  User userLoad = User();
  late Map<String, dynamic> requestMap;
  List<Loan> loanList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: menuAddAppBar(
      //   title: Str.myLoan,
      //   implyLeading: true,
      //   context: context,
      //   hasAction: true,
      //   path: RouteSTR.addLoanM,
      //   onPressed: () => Scaffold.of(context).openDrawer(),
      // ),
      drawer: const SideDrawerMember(),
      backgroundColor: Styles.primaryColor,
      body: _innerContainer(),
    );
  }

  // loadSharedPrefs() async {
  //   try {
  //     User user = User.fromJSON(await sharedPref.read(Pref.userData));
  //     setState(() {
  //       userLoad = user;

  //       print(userLoad.id.toString());
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();

  //   viewOne('3');
  // }

  Future view() async {
    User user = User.fromJSON(await sharedPref.read(Pref.userData));

    String userId = user.id.toString();

    Uri viewSingleUser = Uri.parse(API.userLoanRequestList.toString() + userId);
    final response = await http.get(viewSingleUser, headers: headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);
      for (var req in jsonBody[Field.data]) {
        final data = Loan.fromMap(req);
        if (mounted) {
          loanList.add(data);
        }
      }
    } else {
      // print(Status.failed);
      CustomToast.showMsg(Status.failed, Styles.dangerColor);
    }
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
            return ListView(
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
                            Str.myLoan,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                                color: Styles.textColor, fontSize: 19),
                          ),
                        ),
                        const Gap(10),
                        InkWell(
                          onTap: () => Navigator.pushNamed(context, RouteSTR.addLoanM),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Styles.transparentColor,
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Styles.accentColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                for (Loan loan in loanList) CardLoan(loan: loan),
              ],
            );
          }
        }
      },
    );
  }
}
