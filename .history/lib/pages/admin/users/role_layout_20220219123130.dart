import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/admin/users_methods.dart';
import 'package:flutter_banking_app/models/role.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:gap/gap.dart';
import 'package:oktoast/oktoast.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class RoleLayout extends StatefulWidget {
  const RoleLayout({Key? key, this.role, this.type}) : super(key: key);

  final UserRole? role;
  final String? type;

  @override
  _RoleLayoutState createState() => _RoleLayoutState();
}

class _RoleLayoutState extends State<RoleLayout> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  String? name, description;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
          title: widget.type == Field.update ? Str.updateRo, implyLeading: true, context: context),
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
                    initialValue: widget.role.name,
                    onSaved: (val) => name = val,
                    hintText: Str.name,
                  ),
                  const Gap(20),
                  NewField(
                    mandatory: true,
                    initialValue: widget.role.description,
                    onSaved: (val) => description = val,
                    hintText: Str.description,
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
                          Field.name: name ?? widget.role.name ?? Field.emptyString,
                          Field.description: description ?? widget.role.description ?? Field.emptyString
                        };

                        UserMethods.editUserRole(context, body, widget.role.id.toString());
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
