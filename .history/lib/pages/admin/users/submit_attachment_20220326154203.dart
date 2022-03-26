import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdown_branches.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdown_roles.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdown_user.dart';
import 'package:gap/gap.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../users_layout.dart';

class SubmitAttachment extends StatefulWidget {
  const SubmitAttachment({Key? key, this.transactionId}) : super(key: key);

  final String? transactionId;

  @override
  _AssignWireTransferState createState() => _AssignWireTransferState();
}

class _AssignWireTransferState extends State<SubmitAttachment> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  String? users, usersName;


  FilePickerResult? result;
  PlatformFile? file;
  String fileType = 'All';


  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
          title: Str.assignStaff, implyLeading: true, context: context),
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
                    child: DropDownUser(
                      users: users,
                      usersName: usersName,
                      onChanged: (val) {
                        setState(
                          () {
                            users = val!.id.toString();
                            usersName = val.name;
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
                          Field.assignTo: users ?? Field.emptyInt,
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
                            Uri.parse(AdminAPI.submitAttachment.toString() + widget.transactionId!),
                            Type.staffWireTransfer,
                            const SubmitAttachment(),
                            Str.wireTransfer,
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
