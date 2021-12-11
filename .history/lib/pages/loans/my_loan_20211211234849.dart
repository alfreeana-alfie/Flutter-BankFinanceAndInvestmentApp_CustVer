import 'dart:convert';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/constant/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/app_bar_add.dart';
import 'package:flutter_banking_app/widgets/card_1.dart';
import 'package:flutter_banking_app/widgets/card_loan.dart';
import 'package:flutter_banking_app/widgets/my_app_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class MyLoan extends StatefulWidget {
  const MyLoan({Key? key}) : super(key: key);

  @override
  _MyLoanState createState() => _MyLoanState();
}

class _MyLoanState extends State<MyLoan> {
  // late Map<String, dynamic> userMap;
  // late Map<String, dynamic> verifyMap;
  // List<User> userList = [];

  // Future getList() async {
  //   final response = await http.get(
  //     getUserList,
  //     headers: Values.headers,
  //   );

  //   if (response.statusCode == 200) {
  //     verifyMap = jsonDecode(response.body);

  //     var verifyData = Verify.fromJSON(verifyMap);

  //     if (verifyData.status == ApiSTR.successTxt) {
  //       userMap = jsonDecode(response.body);
  //       for (var userData in userMap['data']) {
  //         final users = User.fromMap(userData);

  //         setState(() {
  //           userList.add(users);
  //         });
  //       }
  //     }
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();

  //   getList();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: addAppBar(
          title: Str.myLoanTxt, 
          implyLeading: 
          true, context: context,
          hasAction: true,
          path: '/apply-new-loan'
          
          ),
      // drawer: SideDrawer(),
      backgroundColor: Styles.primaryColor,
      body: ExpandableTheme(
        data: const ExpandableThemeData(
          iconColor: Colors.blue,
          useInkWell: true,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: const [
              CardLoan(),
              CardLoan(),
              // for (User user in userList) Card1(users: user),
            ],
          ),
        ),
      ),
    );
  }
}
