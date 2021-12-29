import 'dart:convert';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/fdrs.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/app_bar_add.dart';
import 'package:flutter_banking_app/widgets/card/card_fdr.dart';
import 'package:flutter_banking_app/widgets/no_back_appbar.dart';
import 'package:http/http.dart' as http;
import 'package:oktoast/oktoast.dart';

class MFdrList extends StatefulWidget {
  const MFdrList({Key? key}) : super(key: key);

  @override
  _MFdrListState createState() => _MFdrListState();
}

class _MFdrListState extends State<MFdrList> {
  SharedPref sharedPref = SharedPref();
  User userLoad = User();
  late Map<String, dynamic> requestMap;
  List<FixedDeposit> fdrList = [];

  Future view() async {
    User user = User.fromJSON(await sharedPref.read(Pref.userData));

    String userId = user.id.toString();

    Uri viewSingleUser =
        Uri.parse(API.userFixedDepositList.toString() + userId);
    final response = await http.get(viewSingleUser, headers: headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);
      for (var req in jsonBody[Field.data]) {
        final data = FixedDeposit.fromMap(req);
        if(mounted) {
          fdrList.add(data);
        }
      }
    } else {
      print(Status.failedTxt);
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

  //   loadSharedPrefs();
  //   viewOne('3');
  // }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: Scaffold(
        appBar: addAppBar(
          title: Str.fdrHistoryTxt,
          implyLeading: true,
          context: context,
          hasAction: true,
          path: RouteSTR.addFdrM,
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
                    for (FixedDeposit fdr in fdrList) CardFDR(fdrPlan: fdr),
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
