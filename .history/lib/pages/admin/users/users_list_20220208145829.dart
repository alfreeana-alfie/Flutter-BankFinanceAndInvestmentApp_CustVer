import 'dart:convert';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/models/users.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/appbar/app_bar_add.dart';
import 'package:flutter_banking_app/widgets/card/card_users.dart';
import 'package:flutter_banking_app/widgets/left_menu.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:oktoast/oktoast.dart';

class UsersList extends StatefulWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  SharedPref sharedPref = SharedPref();
  User userLoad = User();
  late Map<String, dynamic> requestMap;
  List<Users> userList = [];
  List<Users> _foundUsers = [];

  Future view() async {
    final response = await http.get(AdminAPI.listOfUser, headers: headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);
      for (var req in jsonBody[Field.data]) {
        final data = Users.fromMap(req);
        setState(() {
          userList.add(data);
        });
        // if (mounted) {
        //   userList.add(data);
        // }
      }
    } else {
      print(Status.failed);
      CustomToast.showMsg(Status.failed, Styles.dangerColor);
    }
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Users> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = userList;
    } else {
      results = userList
          .where((user) =>
              user.phone!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();

      if(results.isEmpty){
        results = userList
          .where((user) =>
              user.id.toString().toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();

          setState(() {
            _foundUsers = results;
          });
      }
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  initState() {
    // at the beginning, all users are shown
    view();
    _foundUsers = userList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: addAppBar(
      //   title: Str.userList,
      //   implyLeading: true,
      //   context: context,
      //   hasAction: true,
      //   path: RouteSTR.createUsers,
      // ),
      drawer: const SideDrawer(),
      backgroundColor: Styles.primaryColor,
      body: _innerContainer(),
    );
  }

  _innerContainer() {
    return SafeArea(
      child: Column(
        children: [
          Padding(
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
                    Str.usersList,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Styles.textColor,
                        fontSize: 19),
                  ),
                ),
                const Gap(10),
                InkWell(
                  onTap: () =>
                      Navigator.pushNamed(context, RouteSTR.createUsers),
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
          TextField(
            onChanged: (value) => _runFilter(value),
            decoration: const InputDecoration(
                labelText: 'Search', suffixIcon: Icon(Icons.search)),
          ),
          Expanded(
            child: _foundUsers.isNotEmpty
                ? ListView.builder(
                    itemCount: _foundUsers.length,
                    itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundUsers[index].id),
                      color: Styles.transparentColor,
                      elevation: 0.0,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: CardUser(
                        users: _foundUsers[index],
                        userList: _foundUsers,
                        index: index,
                      )
                      // ListTile(
                      //   leading: Text(
                      //     _foundUsers[index].id.toString(),
                      //     style: const TextStyle(fontSize: 24),
                      //   ),
                      //   title: Text(_foundUsers[index].name ?? 'Users'),
                      //   subtitle: Text('${_foundUsers[index].email} years old'),
                      // ),
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return CardUser(
                        users: userList[index],
                        userList: userList,
                        index: index,
                      );
                    },
                    itemCount: userList.length,
                  ),
          ),
          // for (Users user in userList) CardUser(users: user),
        ],
      ),
    );
    // return FutureBuilder(
    //   future: view(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const Center(
    //         child: CircularProgressIndicator(
    //           color: Styles.accentColor,
    //         ),
    //       );
    //     } else {
    //       if (snapshot.hasError) {
    //         return Center(child: Text('Error: ${snapshot.error}'));
    //       } else {
    //         return Column(
    //           children: [
    //             Padding(
    //               padding: const EdgeInsets.symmetric(vertical: 10),
    //               child: Row(
    //                 // crossAxisAlignment: CrossAxisAlignment.center,
    //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                 children: [
    //                   InkWell(
    //                     onTap: () => Scaffold.of(context).openDrawer(),
    //                     child: Container(
    //                       padding: const EdgeInsets.all(10),
    //                       decoration: const BoxDecoration(
    //                         shape: BoxShape.circle,
    //                         color: Styles.transparentColor,
    //                       ),
    //                       child: const Icon(
    //                         Icons.menu,
    //                         color: Styles.accentColor,
    //                       ),
    //                     ),
    //                   ),
    //                   const Gap(10),
    //                   Center(
    //                     child: Text(
    //                       Str.usersList,
    //                       style: const TextStyle(
    //                           fontWeight: FontWeight.w500,
    //                           color: Styles.textColor,
    //                           fontSize: 19),
    //                     ),
    //                   ),
    //                   const Gap(10),
    //                   InkWell(
    //                     onTap: () =>
    //                         Navigator.pushNamed(context, RouteSTR.createUsers),
    //                     child: Container(
    //                       padding: const EdgeInsets.all(10),
    //                       decoration: const BoxDecoration(
    //                         shape: BoxShape.circle,
    //                         color: Styles.transparentColor,
    //                       ),
    //                       child: const Icon(
    //                         Icons.add,
    //                         color: Styles.accentColor,
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             Expanded(
    //               child: ListView.builder(
    //                 scrollDirection: Axis.vertical,
    //                 shrinkWrap: true,
    //                 itemBuilder: (context, index) {
    //                   return CardUser(
    //                     users: userList[index],
    //                     userList: userList,
    //                     index: index,
    //                   );
    //                 },
    //                 itemCount: userList.length,
    //               ),
    //             ),
    //             // for (Users user in userList) CardUser(users: user),
    //           ],
    //         );
    //       }
    //     }
    //   },
    // );
  }
}
