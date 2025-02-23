import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/dropdown.dart';
import 'package:gap/gap.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../users_layout.dart';

class AssignRole extends StatefulWidget {
  const AssignRole({Key? key, required this.pageTitle, required this.pageType}) : super(key: key);

  @override
  _AssignRoleState createState() => _AssignRoleState();
}

class _AssignRoleState extends State<AssignRole> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  String? userType, roleId, userId, userName, branchId, branchName;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar:
          myAppBar(title: Str.assignRole, implyLeading: true, context: context),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Styles.cardColor,
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                        child:
                            Text(Str.userAccount, style: Styles.primaryTitle),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(7, 0, 0, 10),
                        child: Text(
                          '*',
                          style: TextStyle(color: Styles.dangerColor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    child: DropDownUser(
                      users: userId,
                      usersName: userName,
                      onChanged: (val) {
                        setState(
                          () {
                            userId = val!.id.toString();
                            userName = val.name;
                          },
                        );
                      },
                    ),
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                        child: Text(Str.branch, style: Styles.primaryTitle),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(7, 0, 0, 10),
                        child: Text(
                          '*',
                          style: TextStyle(color: Styles.dangerColor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    child: DropDownBranches(
                      branch: branchId,
                      branchName: branchName,
                      onChanged: (val) {
                        setState(
                          () {
                            branchId = val!.id.toString();
                            branchName = val.name;
                          },
                        );
                      },
                    ),
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                        child: Text(Str.userRoles, style: Styles.primaryTitle),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(7, 0, 0, 10),
                        child: Text(
                          '*',
                          style: TextStyle(color: Styles.dangerColor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    child: DropDownUserRoles(
                      role: roleId,
                      roleName: userType,
                      onChanged: (val) {
                        setState(
                          () {
                            roleId = val!.id.toString();
                            userType = val.name;
                          },
                        );
                      },
                    ),
                  ),
                  const Gap(10),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      color: Styles.primaryColor,
                    ),
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: RoundedLoadingButton(
                      controller: _btnController,
                      color: Styles.secondaryColor,
                      width: double.maxFinite,
                      elevation: 0.0,
                      borderRadius: 15,
                      onPressed: () {
                        Map<String, String> body = {
                          Field.userType: userType ?? Field.emptyString,
                          Field.roleId: roleId ?? Field.empty,
                          Field.branchId: branchId ?? Field.empty,
                          // Field.description: description ?? Field.emptyString
                        };

                        // Method.edit(
                        //     context,
                        //     _btnController,
                        //     body,
                        //     url,
                        //     Type.userList,
                        //     RouteSTR.usersList,
                        //     Str.userList);
                        Method.edit(
                            context,
                            _btnController,
                            body,
                            Uri.parse(AdminAPI.assignRole.toString() +
                                userId.toString()),
                            Type.userList,
                            UsersLayout(
                              pageType: widget.pageType,
                              pageTitle: widget.pageTitle,
                              type: Field.create,
                            ),
                            Str.userList,
                            Field.empty,
                            '');
                      },
                      child: Text(Str.submit.toUpperCase()),
                    ),
                  ),
                  backButton(context)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
