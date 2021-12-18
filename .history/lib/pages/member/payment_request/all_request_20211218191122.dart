import 'dart:convert';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/request.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/utils/values.dart';
import 'package:flutter_banking_app/widgets/app_bar_add.dart';
import 'package:flutter_banking_app/widgets/card_1.dart';
import 'package:flutter_banking_app/widgets/my_app_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class AllRequest extends StatefulWidget {
  const AllRequest({Key? key}) : super(key: key);

  @override
  _AllRequestState createState() => _AllRequestState();
}

class _AllRequestState extends State<AllRequest> {
  late Map<String, dynamic> requestMap;
  // late Map<String, dynamic> verifyMap;
  List<Request> requestList = [];

  Future viewOne(String userId) async {
    Uri viewSingleUser =
        Uri.parse(API.userPaymentRequestList.toString() + userId);
    final response = await http.get(viewSingleUser, headers: API.headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);

      for (var data in jsonBody[Field.data]) {
        final requests = Request.fromMap(data);

        setState(() {
          request
        });
      }
    } else {
      print(Status.failedTxt);
      CustomToast.showMsg(Status.failedTxt, Styles.dangerColor);
    }
  }

  @override
  void initState() {
    super.initState();

    getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: addAppBar(
          title: Str.newRequestTxt,
          implyLeading: true,
          context: context,
          hasAction: true,
          path: RouteSTR.newRequest),
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
              for (Requests request in requestList) Card1(requests: request),
            ],
          ),
        ),
      ),
    );
  }
}
