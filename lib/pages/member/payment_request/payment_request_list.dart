import 'dart:convert';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/request.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/appbar/app_bar_add.dart';
import 'package:flutter_banking_app/widgets/card/card_requests.dart';
import 'package:http/http.dart' as http;

class MPaymentRequestList extends StatefulWidget {
  const MPaymentRequestList({Key? key}) : super(key: key);

  @override
  _MPaymentRequestListtState createState() => _MPaymentRequestListtState();
}

class _MPaymentRequestListtState extends State<MPaymentRequestList> {
  SharedPref sharedPref = SharedPref();
  User userLoad = User();
  late Map<String, dynamic> requestMap;
  List<PaymentRequest> requestList = [];

  Future view() async {
    User user = User.fromJSON(await sharedPref.read(Pref.userData));

    String userId = user.id.toString();

    Uri viewSingleUser =
        Uri.parse(API.userPaymentRequestList.toString() + userId);
    final response = await http.get(viewSingleUser, headers: headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);
      for (var req in jsonBody[Field.data]) {
        final requests = PaymentRequest.fromMap(req);

        if(mounted) {
          requestList.add(requests);
        }
      }
    } else {
      print(Status.failedTxt);
      CustomToast.showMsg(Status.failedTxt, Styles.dangerColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: addAppBar(
          title: Str.newRequestTxt,
          implyLeading: true,
          context: context,
          hasAction: true,
          path: RouteSTR.addPaymentRequestM,
          onPressed: () => Navigator.pushReplacementNamed(context, RouteSTR.dashboardMember)
        ),
      // drawer: SideDrawer(),
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
            physics: const BouncingScrollPhysics(),
            children: [
              for (PaymentRequest request in requestList) CardPaymentRequest(requests: request),
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
