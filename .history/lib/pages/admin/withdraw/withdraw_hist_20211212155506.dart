import 'dart:convert';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class WithdrawHistoryPage extends StatefulWidget {
  const WithdrawHistoryPage({Key? key}) : super(key: key);

  @override
  _WithdrawHistoryPageState createState() => _WithdrawHistoryPageState();
}

class _WithdrawHistoryPageState extends State<WithdrawHistoryPage> {
  late Map<String, dynamic> userMap;
  late Map<String, dynamic> verifyMap;
  List<User> userList = [];

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

  @override
  void initState() {
    super.initState();

    // getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Values.appHeight),
        child: ViewAppBar(
          title: UserSTR.allUsersTxt, 
          widgets: Padding(
            padding: const EdgeInsets.only(right: 8.0, bottom: 5.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/add-new-user');
                },
                child: SvgPicture.asset(
                  'assets/icons/add.svg',
                  width: 20,
                  height: 20,
                  color: Styles.primaryColor,
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  primary: Styles.transparentColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                )),
          ),
        ),
      ),
      drawer: SideDrawer(),
      backgroundColor: Styles.backgroundColor,
      body: ExpandableTheme(
        data: const ExpandableThemeData(
          iconColor: Colors.blue,
          useInkWell: true,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              for (User user in userList) Card1(users: user),
            ],
          ),
        ),
      ),
    );
  }
}
