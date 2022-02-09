import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/branch.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/card/card_branch.dart';
import 'package:flutter_banking_app/widgets/left_menu.dart';
import 'package:flutter_banking_app/widgets/list.dart';
import 'package:gap/gap.dart';
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

  Future view() async {
    final response = await http.get(AdminAPI.listOfBranch, headers: headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);

      for (var req in jsonBody[Field.data]) {
        final data = Branch.fromMap(req);
        if (mounted) {
          branchList.add(data);
        }
      }
    } else {
      CustomToast.showMsg(Status.failed, Styles.dangerColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideDrawer(),
      backgroundColor: Styles.primaryColor,
      body: CardList(typ),
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
            return Column(
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
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
                            Str.branchList,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Styles.textColor,
                                fontSize: 19),
                          ),
                        ),
                        const Gap(10),
                        InkWell(
                          onTap: () => Navigator.pushNamed(
                              context, RouteSTR.createBranch),
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
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return CardBranch(branch: branchList[index], branchList: branchList, index: index,);
                    },
                    itemCount: branchList.length,
                  ),
                ),
                // for (Branch branch in branchList)
                //   CardBranch(branch: branch),
              ],
            );
          }
        }
      },
    );
  }
}
