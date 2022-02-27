import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
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
    return _dropDownSearch();
  }

  _dropDownSearch() {
    return DropdownSearch<UserRole>(
      showSearchBox: true,
      onChanged: widget.onChanged,
      onFind: (String? filter) => getData(filter),
      itemAsString: (planListNew) {
        return planListNew!.description ?? Field.empty ;
      },
      dropdownSearchDecoration: InputDecoration(
        hintText: Str.selectUser,
        filled: true,
        fillColor: Colors.black12.withOpacity(0.05),
        contentPadding: const EdgeInsets.fromLTRB(15, 12, 0, 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Future<List<UserRole>> getData(filter) async {
    return roleListNew;
  }
}