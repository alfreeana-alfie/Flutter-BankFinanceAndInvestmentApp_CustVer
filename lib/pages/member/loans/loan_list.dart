import 'dart:convert';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/loans.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/appbar/app_bar_add.dart';
import 'package:flutter_banking_app/widgets/card/card_loan.dart';
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

  Future view() async {
    User user = User.fromJSON(await sharedPref.read(Pref.userData));

    String userId = user.id.toString();

    Uri viewSingleUser = Uri.parse(API.userLoanRequestList.toString() + userId);
    final response = await http.get(viewSingleUser, headers: headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);
      for (var req in jsonBody[Field.data]) {
        final data = Loan.fromMap(req);
        if(mounted) {
          loanList.add(data);
        }
      }
    } else {
      // print(Status.failedTxt);
      CustomToast.showMsg(Status.failedTxt, Styles.dangerColor);
    }
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

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: Scaffold(
        appBar: addAppBar(
          title: Str.myLoanTxt,
          implyLeading: true,
          context: context,
          hasAction: true,
          path: RouteSTR.addLoanM,
          onPressed: () => Navigator.pushNamed(context, RouteSTR.dashboardMember),
        ),
        // drawer: SideDrawer(),
        backgroundColor: Styles.primaryColor,
        body: _innerContainer(),
      ),
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
                  physics: const BouncingScrollPhysics(),
                  children: [
                    for (Loan loan in loanList) CardLoan(loan: loan),
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
