import 'dart:convert';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/request.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/app_bar_add.dart';
import 'package:flutter_banking_app/widgets/card_fdr.dart';
import 'package:flutter_banking_app/widgets/card_loan.dart';
import 'package:flutter_banking_app/widgets/my_app_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class FdrHistory extends StatefulWidget {
  const FdrHistory({Key? key}) : super(key: key);

  @override
  _FdrHistoryState createState() => _FdrHistoryState();
}

class _FdrHistoryState extends State<FdrHistory> {
  SharedPref sharedPref = SharedPref();
  // User userLoad = User();
  late Map<String, dynamic> requestMap;
  List<FDR> requestList = [];

  Future viewOne(String userId) async {
    Uri viewSingleUser =
        Uri.parse(API.userFixedDepositList.toString() + userId);
    final response = await http.get(viewSingleUser, headers: API.headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);
      for (var req in jsonBody[Field.data]) {
        final requests = PaymentRequest.fromMap(req);

        setState(() {
          requestList.add(requests);
        });
      }
    } else {
      print(Status.failedTxt);
      CustomToast.showMsg(Status.failedTxt, Styles.dangerColor);
    }
  }


  // @override
  // void initState() {
  //   super.initState();

  //   getList();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: addAppBar(
          title: Str.fdrHistoryTxt, 
          implyLeading: 
          true, context: context,
          hasAction: true,
          path: '/apply-new-fdr',
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
              CardFDR(),
              CardFDR(),
              // for (User user in userList) Card1(users: user),
            ],
          ),
        ),
      ),
    );
  }
}
