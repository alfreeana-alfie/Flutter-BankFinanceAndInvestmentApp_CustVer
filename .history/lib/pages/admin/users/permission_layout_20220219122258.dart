import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/admin/users_methods.dart';
import 'package:flutter_banking_app/models/permission.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdown_roles.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:gap/gap.dart';
import 'package:oktoast/oktoast.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class PermissionLayout extends StatefulWidget {
  const PermissionLayout({Key? key, this.permission, this.type})
      : super(key: key);

  final Permission? permission;
  final String? type;

  @override
  _PermissionLayoutState createState() => _PermissionLayoutState();
}

class _PermissionLayoutState extends State<PermissionLayout> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
      
  String? roleId, roleName, permission;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    // setState(() {
    //   permission = widget.permission.permission;
    // });
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
          title: Str.updatePermission,
          implyLeading: true,
          context: context),
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
                        child: Text(Str.bank, style: Styles.primaryTitle),
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
                      roleName: roleName,
                      onChanged: (val) {
                        setState(
                          () {
                            roleId = val!.id.toString();
                            roleName = val.name;
                          },
                        );
                      },
                    ),
                  ),
                  const Gap(20),
                  NewField(
                    mandatory: true,
                    onSaved: (val) => permission = val,
                    hintText: Str.permission,
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0, vertical: 10),
                    child: elevatedButton(
                      color: Styles.secondaryColor,
                      context: context,
                      callback: () {
                        Map<String, String> body = {
                          Field.roleId: roleId ?? widget.permission.roleId.toString(),
                          Field.permission: permission ?? widget.permission.permission ?? Field.emptyString
                        };

                        UserMethods.editPermission(context, body, widget.permission.id.toString());
                      },
                      text: Str.submit,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
