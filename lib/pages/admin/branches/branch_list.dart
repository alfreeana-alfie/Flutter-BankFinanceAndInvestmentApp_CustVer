import 'dart:convert';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/branch.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/app_bar_add.dart';
import 'package:flutter_banking_app/widgets/card_branch.dart';
import 'package:http/http.dart' as http;

class BranchList extends StatefulWidget {
  const BranchList({Key? key}) : super(key: key);

  @override
  _BranchListState createState() => _BranchListState();
}

class _BranchListState extends State<BranchList> {
  SharedPref sharedPref = SharedPref();
  User userLoad = User();
  late Map<String, dynamic> requestMap;
  List<Branch> branchList = [];

  Future viewOne(String userId) async {
    final response = await http.get(AdminAPI.listOfBranch, headers: headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);
      for (var req in jsonBody[Field.data]) {
        final data = Branch.fromMap(req);
        setState(() {
          branchList.add(data);
        });
      }
    } else {
      // print(Status.failedTxt);
      CustomToast.showMsg(Status.failedTxt, Styles.dangerColor);
    }
  }

  loadSharedPrefs() async {
    try {
      User user = User.fromJSON(await sharedPref.read(Pref.userData));
      setState(() {
        userLoad = user;

        print(userLoad.id.toString());
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    loadSharedPrefs();
    viewOne('1');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: addAppBar(
        title: Str.branchTxt,
        implyLeading: true,
        context: context,
        hasAction: true,
        path: RouteSTR.createBranch,
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
            children: [
              for (Branch branch in branchList) CardBranch(branch: branch),
            ],
          ),
        ),
      ),
    );
  }
}
