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
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:gap/gap.dart';
import 'package:oktoast/oktoast.dart';

class CreateUserRole extends StatefulWidget {
  const CreateUserRole({Key? key}) : super(key: key);

  @override
  _CreateUserRoleState createState() => _CreateUserRoleState();
}

class _CreateUserRoleState extends State<CreateUserRole> {
  final ScrollController _scrollController = ScrollController();

  String? name, description;

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
            title: Str.createUserRoleTxt, implyLeading: true, context: context),
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
                    NewField(
                      mandatory: true,
                      onSaved: (val) => name = val,
                      hintText: Str.nameTxt,
                    ),
                    const Gap(20),
                    NewField(
                      mandatory: true,
                      onSaved: (val) => description = val,
                      hintText: Str.descriptionTxt,
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
                            Field.name: name ?? Field.emptyString,
                            Field.description: description ?? Field.emptyString
                          };

                          UserMethods.addUserRole(context, body);
                        },
                        text: Str.submitTxt,
                      ),
                    ),
                  ],
                ),
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
                    Field.name: name ?? Field.emptyString,
                    Field.description: description ?? Field.emptyString
                  };

                  UserMethods.addUserRole(context, body);
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
