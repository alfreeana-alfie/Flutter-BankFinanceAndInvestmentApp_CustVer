import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/admin/navigation_methods.dart';
import 'package:flutter_banking_app/methods/admin/users_methods.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:gap/gap.dart';
import 'package:oktoast/oktoast.dart';

class CreateUserPermission extends StatefulWidget {
  const CreateUserPermission({Key? key}) : super(key: key);

  @override
  _CreateUserPermissionState createState() => _CreateUserPermissionState();
}

class _CreateUserPermissionState extends State<CreateUserPermission> {
  final ScrollController _scrollController = ScrollController();

  String? roleId, permission;

  @override
  void initState() {
    _scrollController.addListener(() {
      print(_scrollController.offset);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return OKToast(
      child: Scaffold(
        backgroundColor: Styles.primaryColor,
        appBar: myAppBar(
            title: Str.createNavigationTxt, implyLeading: true, context: context),
        body: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Styles.accentColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFormField(
                          onChanged: (val) {
                            roleId = val;
                          },
                          style: Styles.subtitleStyle,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: Str.roleTxt,
                            labelStyle: Styles.subtitleStyle,
                            hintText: Str.roleTxt,
                            hintStyle: Styles.subtitleStyle03,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              gapPadding: 0.0,
                            ),
                          ),
                        ),
                        const Gap(20),
                        TextFormField(
                          onChanged: (val) {
                            permission = val;
                          },
                          style: Styles.subtitleStyle,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: Str.permissionTxt,
                            labelStyle: Styles.subtitleStyle,
                            hintText: Str.permissionTxt,
                            hintStyle: Styles.subtitleStyle03,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              gapPadding: 0.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // color: Styles.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
              child: elevatedButton(
                color: Styles.secondaryColor,
                context: context,
                callback: () {
                  Map<String, String> body = {
                    Field.roleId: roleId ?? Field.emptyString,
                    Field.permission: permission ?? Field.emptyString
                  };

                  UserMethods.addPermission(context, body);
                },
                text: Str.submitTxt.toUpperCase(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
