import 'dart:convert';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/permission.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/appbar/app_bar_add.dart';
import 'package:flutter_banking_app/widgets/card/card_user_permission.dart';
import 'package:http/http.dart' as http;
import 'package:oktoast/oktoast.dart';

class PermissionList extends StatefulWidget {
  const PermissionList({Key? key}) : super(key: key);

  @override
  _PermissionListState createState() => _PermissionListState();
}

class _PermissionListState extends State<PermissionList> {
  SharedPref sharedPref = SharedPref();
  User userLoad = User();
  late Map<String, dynamic> requestMap;
  List<Permission> permissionList = [];

  Future view() async {
    final response = await http.get(AdminAPI.listOfPermission, headers: headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);
      for (var req in jsonBody[Field.data]) {
        final data = Permission.fromMap(req);
        setState(() {
          permissionList.add(data);
        });
      }
    } else {
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

  // @override
  // void initState() {
  //   super.initState();

  //   loadSharedPrefs();
  //   viewOne('1');
  // }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: Scaffold(
        appBar: addAppBar(
          title: Str.userListTxt,
          implyLeading: true,
          context: context,
          hasAction: true,
          path: RouteSTR.createPermission,
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
                for (Permission permission in permissionList) CardPermission(permission: permission),
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
