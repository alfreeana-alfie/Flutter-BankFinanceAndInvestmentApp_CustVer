import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_banking_app/models/role.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/iconly/iconly_bold.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:http/http.dart' as http;

class DropDownUserRoles extends StatefulWidget {
   const DropDownUserRoles(
      {Key? key,
      this.role,
      this.roleName,
      // required this.roleList,
      required this.onChanged
      })
      : super(key: key);

  final String? role, roleName;
  final void Function(UserRole?) onChanged;
  // final List<UserRole> roleList;

  @override
  _DropDownUserRolesState createState() => _DropDownUserRolesState();
}

class _DropDownUserRolesState extends State<DropDownUserRoles> {
  List<UserRole> roleListNew = [];

  void getUserRole() async {
    final response = await http.get(AdminAPI.listOfUserRole, headers: headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);

      for (var role in jsonBody[Field.data]) {
        final data = UserRole.fromMap(role);

        setState(() {
          roleListNew.add(data);
        });
      }
    } else {
      print(Status.failed);
    }
  }

  @override
  void initState() {
    super.initState();
    getUserRole();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
      decoration: BoxDecoration(
        color: Colors.black12.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          
          dropdownColor: Styles.greyColor,
          icon: const RotatedBox(
              quarterTurns: 3,
              child: Icon(
                Icons.chevron_left,
                size: 20,
                color: Styles.textColor,
              )),
          hint: widget.roleName == null
              ? Text(Str.role, style: Styles.primaryTitle)
              : Text(
                  widget.roleName!,
                  style: Styles.primaryTitle,
                ),
          isExpanded: true,
          iconSize: 30.0,
          style: Styles.primaryTitle,
          items: roleListNew.map(
            (val) {
              return DropdownMenuItem<UserRole>(
                value: val,
                child: Text(val. ?? Field.emptyString),
              );
            },
          ).toList(),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}